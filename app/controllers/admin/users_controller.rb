module Admin
  class UsersController < BaseController
    def index
      @users = User.all.includes(squads: :nations)
      authorize [:admin, @users]
    end

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

    def edit
      @user = User.find(params[:id])
      authorize [:admin, @user]
    end

    def update
      @user = User.find(params[:id])
      authorize [:admin, @user]

      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Пользователь #{@user.name} обновлён."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :secret, :role, :color, :proposal)
    end
  end
end
