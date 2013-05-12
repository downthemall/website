class SessionsController < ApplicationController
  def create
    user = SignIn.find_or_create_user(params[:assertion], request.host_with_port)
    if user
      authenticate!(user)
      flash[:notice] = I18n.t('authentication.sign_in.notice')
      render json: { success: true }
    else
      authenticate!(nil)
      flash[:alert] = I18n.t('authentication.sign_in.alert')
      render json: { success: false }
    end
  end

  def destroy
    if current_user.present?
      authenticate!(nil)
      flash[:notice] = I18n.t('authentication.sign_out.notice')
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  if Rails.env.test?
    def force_sign_in
      user = User.find(params[:user_id])
      authenticate!(user)
      redirect_to root_path, notice: I18n.t('authentication.sign_in.notice')
    end
  end

end

