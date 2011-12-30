class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource
  before_filter :generate_session_token

  def layout_by_resource
    if devise_controller?
      "editing"
    else
      "application"
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session[:session_token])
  end

  private

  def generate_session_token
    session[:session_token] ||= SecureRandom.base64(100)
  end

end
