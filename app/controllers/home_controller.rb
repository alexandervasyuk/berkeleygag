class HomeController < ApplicationController

	def index
		if signed_in?
			@post = current_user.posts.build
		end
		@feed_items = Post.by_votes_freshest.page(params[:page]).per_page(1)
	end

	def haha
		if signed_in?
			@post = current_user.posts.build
		end
		@feed_items = Post.by_votes_up.page(params[:page]).per_page(1)
	end

	def meh
		if signed_in?
			@post = current_user.posts.build
		end
		@feed_items = Post.by_votes_down.page(params[:page]).per_page(1)
	end

	def access_denied

	end

	def not_found

	end
end