module SessionAuthentication
  class AuthenticatedUserRequired < RuntimeError; end
  class UnauthenticatedUserRequired < RuntimeError; end

  def self.registered(app)
    app.helpers Helpers
  end

  module Helpers
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def require_non_signed_in_user!
      raise SessionAuthentication::UnauthenticatedUserRequired if current_user
    end

    def require_signed_in_user!
      raise SessionAuthentication::AuthenticatedUserRequired unless current_user
    end

    def authenticate!(user)
      if user
        session[:user_id] = user.id
        user
      else
        session[:user_id] = nil
      end
    end
  end
end

