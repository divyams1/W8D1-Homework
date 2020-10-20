
class SessionsController < ApplicationController 

    before_action :ensure_logged_in?, only: [:destroy]

    def new 
      debugger
        render :new 
    end 

    def create 
        
          @user =  User.find_by_credentials(params[:user][:username], params[:user][:password])
          if @user.nil?
            flash[:errors] = ["Invalid username or password"]
            render :new 
          else 
            log_in!(@user)
            redirect_to users_url
          end 
    end 

    def destroy 
        logout
        redirect_to new_session_url
    end
end