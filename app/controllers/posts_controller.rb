class PostsController < ApplicationController
	before_filter :signed_in_user, only:[:create]
	
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
		raise AccessDenied unless post.owned_by?(current_user)
		post.destroy
		redirect_to root_path
	end

private

	def post_params
		params.require(:post).permit(:title, :photo)
	end
end