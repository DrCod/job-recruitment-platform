class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index,:edit, :update,:destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user ,  only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] ="User destroyed"
    redirect_to users_path
  end

  def index
    @users =User.paginate(page: params[:page])
  end

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

  private 

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path , notice: "Please sign in."
      end
    end

    def correct_user
      @user =User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end


    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
