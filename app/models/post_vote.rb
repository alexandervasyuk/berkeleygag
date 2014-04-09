class PostVote < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :value, inclusion: {in: [1, -1]}
	validates :post_id, uniqueness: {scope: :user_id}
	#validate :ensure_not_author

	def ensure_not_author
		errors.add :user_id, "is author of post" if post.user_id == user_id
	end
end