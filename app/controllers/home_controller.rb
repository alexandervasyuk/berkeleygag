class HomeController < ApplicationController

	def index
		if signed_in?
			@post = current_user.posts.build
		end
		@feed_items = Post.all
	end
end