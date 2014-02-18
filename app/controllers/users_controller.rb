class UsersController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    else
      flash[:warning] = "Please sign in"
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
      flash[:warning] = "Please sign in"
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Welcome to Timezone Reminder!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
