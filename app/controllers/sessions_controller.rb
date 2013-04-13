class SessionsController < Controller

  post :sign_in, map: '/sign_in' do
    require_non_signed_in_user!
    user = SignIn.find_or_create_user(params[:assertion], request.host_with_port)
    if user
      authenticate!(user)
      flash[:notice] = I18n.t('authentication.sign_in.notice')
      JSON.dump(success: true)
    else
      flash[:alert] = I18n.t('authentication.sign_in.alert')
      JSON.dump(success: false)
    end
  end

  post :sign_out, map: '/sign_out' do
    require_signed_in_user!
    authenticate!(nil)
    flash[:notice] = I18n.t('authentication.sign_out.notice')
    JSON.dump(success: true)
  end

  if Padrino.env == :test
    get :force_sign_in, map: '/force_sign_in' do
      user = User.find(params[:user_id])
      authenticate!(user)
      I18n.t('authentication.sign_in.notice')
    end
  end

end

Downthemall.controller :sessions do
  SessionsController.install_routes!(self)
end

