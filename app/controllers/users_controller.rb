class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			UserMailer.confirm(@user).deliver
			flash[:success] = "Nice, bro. To gain full priviliges, check your email"
			redirect_to root_path
		else 
			flash.now[:error] = "Invalid input bro, you ought to be a berkeley student"
			render :new
		end
	end

	def confirm
		user = User.find_by_confirmation_code(params[:token])

		if user && user.confirm(params[:token])
			flash[:success] = "You account is verified. You can now post"
			redirect_to root_path
		else
			flash[:error] = "Why you contriving bro"
			redirect_to root_path
		end
	end

	def show
		@user = User.find(params[:id]) 
		@posts = @user.posts
	end
private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end