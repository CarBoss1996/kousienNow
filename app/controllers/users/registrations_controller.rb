class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    # LINEログインの場合はemailの確認をスキップ
    logger.debug "Provider: #{params[:user][:provider]}"
    resource.skip_confirmation! if params[:user][:provider] == 'line'

    resource.save
    logger.debug "Resource saved: #{resource.persisted?}"

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}"))
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    email_changed = resource.email != params[:user][:email]
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if email_changed
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
