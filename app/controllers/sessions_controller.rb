class SessionsController < ApplicationController
  def create
    user = User.find_by(secret: params[:secret])

    if user
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "Вы залогинились как #{user.name}"
    else
      redirect_to root_path, alert: "Неверная ссылка для входа"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Вы разлогинились"
  end
end
