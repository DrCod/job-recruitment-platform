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

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update_attributes(params[:user])
      #Handle successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end
