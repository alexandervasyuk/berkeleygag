module ApplicationHelper

	def flash_class(level)
		case level 
		when :notice
			"alert alert-info"
		when :error
			"alert alert-danger"
		when :alert
			"alert alert-warning"
		when :success
			"alert alert-success"
		end
	end

	def already_voted?(user, post) 
		PostVote.where(user_id:user.id, post_id:post.id).any?
	end
end
