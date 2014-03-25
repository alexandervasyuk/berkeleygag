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

	def vote
		@vote = current_user.post_votes.build(value:params[:value], post_id:params[:id])
		if @vote.save
			respond_to do |f|
				f.html {redirect_to :back, notice: "Thanks"}
				f.js
			end
		else
			respond_to do |f|
				f.html do 
					flash[:error] = "Unable to vote"
					redirect_to :back
				end
				f.js
			end
		end
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