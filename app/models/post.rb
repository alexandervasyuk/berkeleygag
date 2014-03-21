class Post < ActiveRecord::Base
	belongs_to :user

	validates :title, presence:true

	mount_uploader :photo, PhotoUploader
end