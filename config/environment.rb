# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :domain => 'automan-ec.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}