class Users::RegistrationsController < Devise::RegistrationsController
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

    if resource.provider.present? # SNS認証を使用している場合
      resource_updated = resource.update_without_password(account_update_params)
    else
      resource_updated = update_resource(resource, account_update_params)
    end

    yield resource if block_given?
    if resource_updated
      case
      when resource.email != params[:user][:email] && resource.email.include?('@kasutamu.line')
        existing_user = User.find_by(email: params[:user][:email])
        if existing_user
          # メールアドレスがすでに存在する場合は、そのユーザーにSNS認証情報を追加
          SnsCredential.create(user_id: existing_user.id, provider: 'line', uid: resource.uid)
          resource.destroy
          self.resource = existing_user
        else
          # メールアドレスが存在しない場合は、メールアドレスを更新
          resource.unconfirmed_email = nil
        end
      when resource.email != params[:user][:email]
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

  protected

  def after_sign_up_path_for(resource)
    user_path(resource, show_guide_modal: true)
  end
end
