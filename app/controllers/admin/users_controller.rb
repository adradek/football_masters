module Admin
  class UsersController < BaseController
    def new
      @user = User.new(secret: SecureRandom.hex(16))
      authorize [:admin, @user]
    end

    def create
      @user = User.new(user_params)
      authorize [:admin, @user]

      if @user.save
        redirect_to new_admin_user_path, notice: "Пользователь #{@user.name} создан."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :secret, :role, :color)
    end
  end
end
