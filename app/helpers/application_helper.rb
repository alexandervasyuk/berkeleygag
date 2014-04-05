module ApplicationHelper

	def flash_class(level)
		case level 
		when :notice
			"alert alert-info"
		when :error
			"alert alert-error"
		when :alert
			"alert alert-error"
		when :success
			"alert alert-success"
		end
	end
end
