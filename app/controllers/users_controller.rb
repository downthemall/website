class UsersController < Controller

  get :sign_up, map: '/sign_up' do
    require_non_signed_in_user!

    @user = User.new
    render 'users/sign_up'
  end

  post :sign_up, map: '/sign_up' do
    require_non_signed_in_user!

    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = I18n.t('authentication.sign_up.notice')
      session[:user_id] = @user.id
      redirect url(:index)
    else
      render 'users/sign_up'
    end
  end

end

Downthemall.controller :users do
  UsersController.install_routes!(self)
end

