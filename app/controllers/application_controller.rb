class ApplicationController < ActionController::Base
    before_action :authenticate_profile_or_token!
    before_action :authenticate_profile!, unless: :token_authenticated?

    def authenticate_profile_or_token!
        if current_profile.nil?
          authenticate_with_token!
        end
      end

    def authenticate_with_token!
        puts "started"
        authenticate_with_http_token do |token, _options|
            profile = Profile.find_by(authentication_token: token)
            if profile
            puts profile
            @current_profile = profile
            else
            puts "error"
            head :unauthorized
            end
        end
    end

    def token_authenticated?
        !!@current_profile
    end
end
