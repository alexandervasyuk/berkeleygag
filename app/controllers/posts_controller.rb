class PostsController < ApplicationController
	before_filter :signed_in_user, only:[:create]
	before_filter :correct_user, only:[:destroy]
	
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to root_path
		else
			flash.now[:error] = "Invalid input"
			render 'home/index'
		end
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy
		redirect_to user_path(post.user)
	end

private

	def correct_user
		post = Post.find(params[:id])
		raise AccessDenied unless post.owned_by?(current_user)
	end

	def post_params
		params.require(:post).permit(:title, :photo)
	end
end