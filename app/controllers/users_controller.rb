class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if  @user.save
      sign_in @user
      flash[:success]="Welcome to the job recruitment platform"
      redirect_to @user
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email,:address,:phone, :password, :password_confirm)
  end
end
