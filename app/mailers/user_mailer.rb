class UserMailer < ActionMailer::Base
	def confirm(user)
		@user = user
		mail( to: @user.email, subject: "BerkeleyGag registration" )
	end
end