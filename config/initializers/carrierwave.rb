CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                       # required
    :aws_access_key_id      => 'AKIAILDZQMRAYQGSC4LA',                      # required
    :aws_secret_access_key  => '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',  # required
    :region                 => 'us-west-1'
  }
  config.fog_directory  = 'berkeleygag'                           # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

	if Rails.env.test? or Rails.env.cucumber? or Rails.env.development?
		config.storage = :file
		config.enable_processing = false
	else
		config.storage = :fog
		config.enable_processing = true
	end
end