class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :not_signed_in,   only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Welcome to Timezone Reminder!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
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

    #Before Filters

    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def not_signed_in
      unless !signed_in?
        redirect_to root_url
      end
    end
end
