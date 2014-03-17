class User < ActiveRecord::Base
	has_secure_password
	
	VALID_EMAIL_REGEX = /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*berkeley\.edu\b/i

	validates :email, presence:true
	validates :email, uniqueness: { case_sensitive: false }
	validates :email, format: { with: VALID_EMAIL_REGEX }

	before_save :set_confirmation_code

	def confirm(token)
		if self.confirmation_code == token
			self.confirmation_code = "Verified"
			self.save
		else
			false
		end
	end

private

	def set_confirmation_code
		if self.confirmation_code == nil && self.confirmation_code != "Verified"
			self.confirmation_code = Digest::SHA1.hexdigest([Time.now, rand].join)
		end
	end
end