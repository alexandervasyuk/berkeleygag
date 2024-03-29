class SessionsController < ApplicationController

	def new
		@login = Login.new
	end

	def create 
		@login = Login.new(params[:login])
		if @login and @login.authenticate
			session[:user_id] = @login.authenticate
			redirect_to root_url
		else
			flash.now[:error] = "Invalid email/password combination."
			render :new
		end

	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end