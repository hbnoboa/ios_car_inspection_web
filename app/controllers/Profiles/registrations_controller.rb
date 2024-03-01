class Profiles::RegistrationsController < Devise::RegistrationsController
  layout 'login'
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    
    super
  end

  def create
    super
  end

  def update
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :login, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :login, :role])
  end

  # If you have extra routes after Devise, override the after_sign_up_path_for method
  def after_sign_up_path_for(resource)
    # Customize the path as needed
    root_path
  end
end
