class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :complete_account_signup, if: "user_signed_in? && !current_user.account.present?"

  private
      
    def after_sign_in_path_for(resource_or_scope)
      # request.env['omniauth.origin'] || root_url#profile_path
      new_account_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])

      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
    end

    # NOTE: pundit authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def user_not_authorized
      # flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    # NOTE: redirect users back to the signup page if they haven't completed setting up their account.
    def complete_account_signup
      flash[:alert] = "Please complete your profile before continuing."
        redirect_to new_account_path
    end

end
