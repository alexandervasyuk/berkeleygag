class PostsController < ApplicationController
	before_filter :signed_in_user
	
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to root_path
		else
			flash.now[:error] = "Invalid input"
			render 'home/index' 
		end
	end

private

	def post_params
		params.require(:post).permit(:title, :photo)
	end
end