class Post < ActiveRecord::Base
	before_save :default_values

	belongs_to :user
	has_many :post_votes, dependent: :destroy
	
	validates :title, presence:true, length: { maximum: 60 }
	validates :photo, presence:true
	validates :original_creator, length: {maximum:40}
	
	mount_uploader :photo, PhotoUploader

	def votes
		post_votes.sum(:value)
	end

	def self.by_votes_up
		select('posts.*, coalesce(value, 0) as votes').
		joins('left join post_votes on post_id=posts.id').
		order('votes desc')
	end

	def self.by_votes_down
		select('posts.*, coalesce(value, 0) as votes').
		joins('left join post_votes on post_id=posts.id').
		order('votes asc')
	end

	def self.by_votes_freshest
		select('posts.*').
		order('created_at desc')
	end

	def owned_by?(user)
		user && user.id == self.user.id
	end

private

	def default_values
		self.original_creator ||= ''
	end
end