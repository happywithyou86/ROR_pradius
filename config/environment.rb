# Load the Rails application.
require File.expand_path('../application', __FILE__)
Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")
# Initialize the Rails application.
Pr::Application.initialize!

# ActionMailer::Base.smtp_settings = {
#   :port =>           '587',
#   :address =>        'smtp.mandrillapp.com',
#   :user_name =>      ENV['MANDRILL_USERNAME'],
#   :password =>       ENV['MANDRILL_APIKEY'],
#   :domain =>         'heroku.com',
#   :authentication => :plain
# }
