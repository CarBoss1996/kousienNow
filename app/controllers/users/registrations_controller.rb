class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        session[:new_user] = true
      end
    end
  end

  def update
    email_changed = resource.email != params[:user][:email]
    super do |resource|
      if email_changed
        resource.unconfirmed_email = resource.email
        resource.email = resource.email_was
        resource.send_confirmation_instructions
      end
    end
  end

  protected

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end
end
