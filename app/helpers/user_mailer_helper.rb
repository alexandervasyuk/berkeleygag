module UserMailerHelper
	
	def confirm_url(code)
		"http://localhost:3000/confirm/#{code}"
	end
end