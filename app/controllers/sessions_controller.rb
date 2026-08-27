class SessionsController < ApplicationController
  before_action :require_logout, only: :new

  def new
  end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)

    if user&.authenticate(params.dig(:session, :password))
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'ログインしました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードに誤りがあります'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: 'ログアウトしました'
  end
end
