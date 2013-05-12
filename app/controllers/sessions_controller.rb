class SessionsController < Controller

  post :sign_in, map: '/sign_in', provides: :json do
    user = SignIn.find_or_create_user(params[:assertion], request.host_with_port)
    if user == current_user
      JSON.dump(success: true, changed: false)
    elsif
      authenticate!(user)
      flash[:notice] = I18n.t('authentication.sign_in.notice')
      JSON.dump(success: true, changed: true)
    else
      authenticate!(nil)
      flash[:alert] = I18n.t('authentication.sign_in.alert')
      JSON.dump(success: false, changed: true)
    end
  end

  post :sign_out, map: '/sign_out', provides: :json do
    if current_user.present?
      authenticate!(nil)
      flash[:notice] = I18n.t('authentication.sign_out.notice')
      JSON.dump(success: true, changed: true)
    else
      JSON.dump(success: true, changed: false)
    end
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

