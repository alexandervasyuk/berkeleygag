class UserMailer < ActionMailer::Base
	default from: "registration@berkeleygag.com"

	def confirm(email)
		mail( to: email, subject: "BerkeleyGag registration" )
	end
end