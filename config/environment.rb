# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "json"
  config.gem "eventmachine"
  config.gem "juggernaut"
  config.gem "haml"

  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  config.time_zone = 'UTC'

  config.action_controller.session = {
    :session_key => '_skip-talk_session',
    :secret      => 'fabb453d435bee99b72fee32dcb0b322534dd2d953152f36990ed90c043d29e05a77b537415664a0fe639520769b6fe9d0af49cecbf28afdde4b6a2bea22ff4d'
  }
end
