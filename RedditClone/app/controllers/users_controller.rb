class UsersController < ApplicationController

    def new 
        @user = User.new 
        render :new 
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            log_in!(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:error] = @user.errors.full_messages
            render :new
        end
    end

    def index
        debugger
        @users = User.all 
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

end