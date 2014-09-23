class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:show, :edit, :update]
	before_filter :correct_user, only: [:show, :edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			UserMailer.confirm(@user).deliver

			flash[:success] = "To gain full priviliges, check your email. It might be in the spam folder."
			redirect_to root_path
		else 
			flash.now[:error] = "Sorry, something went wrong. Please check for errors."
			render :new
		end
	end

	def confirm
		user = User.find_by_confirmation_code(params[:token])

		if user && user.confirm(params[:token])
			flash[:success] = "You account is verified. You can now post."
			redirect_to root_path
		else
			flash[:error] = "Sorry, something went wrong."
			redirect_to root_path
		end
	end

	def show
		begin
			@user = User.find(params[:id]) 
			@posts = @user.posts
		rescue
			flash[:error] = "User does not exist"
      		redirect_to root_path
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
	    @user = User.find(params[:id])
	    if @user.update_attributes(user_params)
	      redirect_to @user, notice: "Your profile has been updated"
	    else
	      flash.now[:error] = "Please, provide valid password for the user"
	      render :edit
	    end
	end
private

	def correct_user
		user = User.find(params[:id])
		raise AccessDenied unless user.owned_by?(current_user)
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end