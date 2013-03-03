module AuthorizationHelpers

  def require_admin_user!
    require_logged_user!
    unless current_user.admin?
      flash[:alert] = I18n.t('authorization.admin_required')
      redirect url(:index)
    end
  end

end
