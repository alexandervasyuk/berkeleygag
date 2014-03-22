class Post < ActiveRecord::Base
	belongs_to :user

	validates :title, presence:true

	mount_uploader :photo, PhotoUploader

	def owned_by?(user)
		user && user.id == self.user.id
	end
end