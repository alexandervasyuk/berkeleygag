class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			UserMailer.confirm(@user.email).deliver
			flash[:success] = "Nice, bro. Now check your email to confirm your account"
			redirect_to root_path
		else 
			flash.now[:error] = "Invalid input bro, you ought to be a berkeley student"
			render :new
		end
	end

private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end