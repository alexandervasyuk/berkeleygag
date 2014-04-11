module UserMailerHelper
	
	def confirm_url(code)
		"http://berkeleygag.com/confirm/#{code}"
	end
end