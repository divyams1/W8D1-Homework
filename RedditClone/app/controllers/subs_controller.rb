class SubsController < ApplicationController 
    before_action :require_moderator, only: [:edit]
    def new 
        @sub = Sub.new 
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.user_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages 
            render :new
        end 
    end

    def show 
        @subs = Sub.all
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def index
        @subs = Sub.all 
        render :index
    end

    def destroy 
        @sub = Sub.find_by(id: params[:id])
        if @sub.is_moderator?(current_user)
            @sub.destroy 
        end
        redirect_to user_url(current_user)
    end
    

    def edit 
        @sub = Sub.find_by(id: params[:id] )
        render :edit 
    
    end 

    def update
        @sub = Sub.find_by(id: params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    private 
    def sub_params 
        params.require(:sub).permit(:title, :description)
    end
end