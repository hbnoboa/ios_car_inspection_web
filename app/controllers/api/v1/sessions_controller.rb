class Api::V1::SessionsController < Devise::SessionsController
    protect_from_forgery with: :null_session
    respond_to :json
    before_action :configure_sign_in_params, only: [:create]
  
    def create
      resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      token = generate_token(resource)
      render json: { success: true, message: 'Logged in successfully', profile: resource, auth_token: token }
    end
  
    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      render json: { success: true, message: 'Logged out successfully' }
    end
  
    protected
  
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    end
  
    private
  
    def generate_token(profile)
      profile.ensure_authentication_token
      profile.save!
    end
  end
  
# curl -X POST -H "Content-Type: application/json" 
# -d '{"api_v1_user": {"email": "hbnoboa11@gmail.com", "password": "@#12345Ab"}}' 
# https://ios-car-f8bf78f8eb62.herokuapp.com/api/v1/users/sign_in