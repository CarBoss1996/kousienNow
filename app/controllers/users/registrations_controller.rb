class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end
end
