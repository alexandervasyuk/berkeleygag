class UserMailer < ActionMailer::Base
	default from: "app23413987@heroku.com"

	def confirm(user)
		@user = user
		mail( to: @user.email, subject: "BerkeleyGag registration" )
	end
end