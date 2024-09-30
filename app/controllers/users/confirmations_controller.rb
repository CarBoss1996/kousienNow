# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?

      if resource.errors.empty?
        sign_in(resource)
        respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
      else
        respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
      end
    end

    protected

    def after_confirmation_path_for(resource_name, resource)
      if cookies[:new_user]
        flash[:success] = I18n.t('devise.registrations.signed_up')
        cookies[:new_user] = false
        root_path(show_guide_modal: true)
      else
        super
      end
    end
  end
end
