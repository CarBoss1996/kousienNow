# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        if resource.persisted?
          flash[:notice] = I18n.t('devise.registrations.signed_up')
          cookies[:new_user] = true
        end
      end
    end

    def update
      logger.debug "ここを見て！！！Current resource: #{send(:"current_#{resource_name}")}"
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").id)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      existing_user = User.find_by(email: params[:user][:email])
      if existing_user && resource.email != params[:user][:email] && resource.email.include?('@kasutamu.line')
        # メールアドレスがすでに存在する場合は、そのユーザーにSNS認証情報を追加
        sns_credential = resource.sns_credentials.find_by(provider: 'line')
        if sns_credential
          SnsCredential.create(user_id: existing_user.id, provider: sns_credential.provider, uid: sns_credential.uid)
          # @kasutamu.lineのアカウントを削除
          resource.sns_credentials.destroy_all # この行を追加
          resource.destroy
          self.resource = existing_user
          respond_with resource, location: after_update_path_for(resource)
        end
      else
        resource_updated = if resource.sns_credentials.any? # SNS認証を使用している場合
                             resource.update_without_password(account_update_params)
                           else
                             update_resource(resource, account_update_params)
                           end

        yield resource if block_given?
        if resource_updated
          if resource.email != params[:user][:email] && resource.email.include?('@kasutamu.line')
            if existing_user.nil?
              # メールアドレスが存在しない場合は、メールアドレスを更新
              resource.unconfirmed_email = nil
            end
          elsif resource.email != params[:user][:email]
            resource.unconfirmed_email = resource.email
            resource.email = resource.email_was
            resource.send_confirmation_instructions
          end
          set_flash_message_for_update(resource, prev_unconfirmed_email)
          bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

          respond_with resource, location: after_update_path_for(resource)
        else
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource
        end
      end
    end

    protected

    def after_sign_up_path_for(resource)
      user_path(resource, show_guide_modal: true)
    end

    def account_update_params
      params = devise_parameter_sanitizer.sanitize(:account_update)
      if resource.sns_credentials.any?
        params.delete(:current_password) # SNS認証を使用しているユーザーはcurrent_passwordを必要としない
      end
      params
    end
  end
end
