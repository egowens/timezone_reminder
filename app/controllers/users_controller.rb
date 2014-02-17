class UsersController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def show
    if signed_in?
      @user = User.find_by_id(params[:id])
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Timezone Reminder!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
