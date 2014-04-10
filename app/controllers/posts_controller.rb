class PostsController < ApplicationController
	before_filter :signed_in_user, only:[:create, :vote]
	before_filter :correct_user, only:[:destroy]
	before_filter :verified_user?, only:[:create, :vote]
	
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			respond_to do |f|
				f.html {redirect_to :back}
				f.js
			end
		else
			respond_to do |f|
				f.html do
					flash[:error] = "Can not post without a valid title and a photo or link, bro"
					redirect_to :back
				end
				f.js
			end
		end
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy
		redirect_to :back
	end

	def show
		begin
			@post = Post.find(params[:id])
		rescue
			flash[:error] = "User does not exist"
      		redirect_to root_path
		end
	end

	def vote
		if PostVote.where(user_id:current_user.id, post_id:params[:id]).any?
			@vote = PostVote.where(user_id:current_user.id, post_id:params[:id])[0]
			@vote.update_attributes(value:params[:value], post_id:params[:id])
		else
			@vote = current_user.post_votes.build(value:params[:value], post_id:params[:id])
			if @vote.save
				respond_to do |f|
					f.html {redirect_to :back, notice: "Thanks for voting"}
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
	end

private

	def correct_user
		post = Post.find(params[:id])
		raise AccessDenied unless post.owned_by?(current_user)
	end

	def post_params
		memeful_url = "http://memeful.com/meme/"
		if params[:post][:remote_photo_url].include?(memeful_url)
			params[:post][:remote_photo_url] = "http://i.memeful.com/memes/" + params[:post][:remote_photo_url].split(memeful_url)[1] + '.jpg'
		end

		params.require(:post).permit(:title, :photo, :remote_photo_url, :original_creator)
	end
end