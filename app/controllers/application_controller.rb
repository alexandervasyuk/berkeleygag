class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from AccessDenied, with: :access_denied

  include SessionsHelper

protected 

	def access_denied
		redirect_to access_denied_path
	end
end
