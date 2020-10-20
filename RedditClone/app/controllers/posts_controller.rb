class PostsController < ApplicationController

    def new
        @post = Post.new 
        render :new 
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id 
        @post.sub_id = params[:sub_id]
        if @post.save 
            
            params[:post][:sub_id].each do |sub_id| 
                PostSub.create!(post_id: @post.id , sub_id: sub_id)
            end 
            redirect_to sub_url(@post.sub)
        else 
            flash.now[:errors] = @post.errors.full_messages 
            render :new 
        end 
    end

   def show 
    @post = Post.find_by(id: params[:id])
    render :show 
   end 

   def edit
    @subs = Sub.all 
        @post = Post.find_by(id: params[:id])
        if @post.author == current_user
            render :edit 
        end 
    
   end 

   def update 
        @post = Post.find_by(id: params[:id])
        if @post.update(post_params)
            redirect_to sub_url(@post.sub)
        else 
            flash.now[:errors] = @post.errors.full_messages
            render :edit 
        end
   end

   def destroy 
        @post = Post.find_by(id: params[:id])
        if @post.author == current_user
            @post.destroy 
        else 
            redirect_to sub_url(@post.sub)
        end

   end 

    private

    def post_params
        params.require(:post).permit(:title, :url, :content)
    end

end