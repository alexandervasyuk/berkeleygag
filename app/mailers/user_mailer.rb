class UserMailer < ActionMailer::Base
	default from: "registration@berkeleygag.com"

	def confirm(user)
		@user = user
		mail( to: @user.email, subject: "BerkeleyGag registration" )
	end
end