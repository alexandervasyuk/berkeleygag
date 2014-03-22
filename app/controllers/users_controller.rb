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

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end