# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Berkeleygag::Application.initialize!

if Rails.env == "production" 
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.perform_deliveries = true
	ActionMailer::Base.raise_delivery_errors = true
	ActionMailer::Base.smtp_settings = 
	{
		:address            => 'smtp.sendgrid.net',
		:port               => 587,
		:authentication     => :plain,
		:user_name          => ENV['SENDGRID_USERNAME'],
		:password           => ENV['SENDGRID_PASSWORD'],
		:domain             => 'heroku.com',
		:enable_starttls_auto => true
	}
end