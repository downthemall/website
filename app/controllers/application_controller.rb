class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit
  include SessionAuthentication

  alias_method :authorize!, :authorize
  helper_method :current_user

  before_filter :set_locale

  protected

  def set_locale
    if params[:locale].nil?
      I18n.locale = "en"
    else
      I18n.locale = params[:locale]
    end
  end

  def default_url_options(options={})
      { :locale => I18n.locale }
  end
end

