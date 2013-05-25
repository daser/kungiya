# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Esusu::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings[:openssl_verify_mode] = false
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false