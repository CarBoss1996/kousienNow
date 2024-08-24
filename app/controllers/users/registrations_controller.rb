class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        session[:new_user] = true
      end
    end
  end

  protected

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end
end
