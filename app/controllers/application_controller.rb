class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource_or_scope)
    current_user # redirects to a user's show page
  end

  # NOTE: Adding new paramters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :company, :account_type, :password, :password_confirmation])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :company, :account_type, :email, :password, :password_confirmation, :current_password])
  end

end
