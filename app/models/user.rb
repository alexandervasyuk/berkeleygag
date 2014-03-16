class User < ActiveRecord::Base
	has_secure_password
	
	VALID_EMAIL_REGEX = /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*berkeley\.edu\b/i

	validates :email, presence:true
	validates :email, uniqueness: { case_sensitive: false }
  	validates :email, format: { with: VALID_EMAIL_REGEX }
end