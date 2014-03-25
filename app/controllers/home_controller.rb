class HomeController < ApplicationController

	def index
		if signed_in?
			@post = current_user.posts.build
		end
		@feed_items = Post.by_votes
	end

	def access_denied

	end

	def not_found

	end
end