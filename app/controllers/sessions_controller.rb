class SessionsController < Controller

  get :sign_in, map: '/sign_in' do
    require_non_logged_user!
    @user = User.new
    render 'sessions/sign_in'
  end

  post :sign_in, map: '/sign_in' do
    require_non_logged_user!
    begin
      user = Authentication.authenticate!(params[:email], params[:password])
      flash[:notice] = I18n.t('authentication.sign_in.notice')
      session[:user_id] = user.id
      redirect url(:index)
    rescue Authentication::Fail
      flash.now[:alert] = I18n.t('authentication.sign_in.alert')
      render 'sessions/sign_in'
    end
  end

  get :sign_out, map: '/sign_out' do
    require_logged_user!
    session.clear
    flash[:notice] = I18n.t('authentication.sign_out.notice')
    redirect url(:index)
  end

end

Downthemall.controller :sessions do
  SessionsController.install_routes!(self)
end

