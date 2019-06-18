class SessionsController < ApplicationController

    def new
    end


    def create
        #user =User.find_by_email(params[:session][:email])
        @user = User.find_by(email: params[:session][:email].downcase)

        if @user && @user.authenticate(params[:session][:password])
            #sign user in and re-direct user to home page
            sign_in @user
            redirect_back_or @user    
        else
            #re-render the login page and an error message
            flash.now[:error] ='Invalid email and password combination'
            render 'new'    
        end
    end

    def destroy
        sign_out
        redirect_to root_path
    end 
end
