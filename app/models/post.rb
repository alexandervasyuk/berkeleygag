class Post < ActiveRecord::Base
	belongs_to :user
	has_many :post_votes
	
	validates :title, presence:true

	mount_uploader :photo, PhotoUploader

	def votes
		post_votes.sum(:value)
	end

	def self.by_votes
		select('posts.*, coalesce(value, 0) as votes').
		joins('left join post_votes on post_id=posts.id').
		order('votes desc')
	end

	def owned_by?(user)
		user && user.id == self.user.id
	end
end