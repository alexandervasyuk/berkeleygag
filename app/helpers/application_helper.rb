module ApplicationHelper

	def top_menu
		result = content_tag(:ul, class: "nav pull-left") do
	    end

	    result += content_tag(:ul, class: "nav pull-right") do
	      if current_user
	        items = content_tag(:li, link_to("Welcome, #{current_user.email}", user_path(current_user)))
	        items += tag(:li, class: "divider-vertical")
	        items += content_tag(:li, link_to("Sign out", signout_path))
	      else
	        items = content_tag(:li, link_to("Sign up", signup_path))
	        items += tag(:li, class: "divider-vertical")
	        items += content_tag(:li, link_to("Sign in", signin_path))
	      end
	      items
	    end

	    result
	end

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
