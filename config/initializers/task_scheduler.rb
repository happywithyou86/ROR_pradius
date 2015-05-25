require 'rubygems'
require 'rufus/scheduler'
 
scheduler = Rufus::Scheduler.new
 
scheduler.every '1m' do
     system 'RAILS_ENV="production" ruby config/sitemap.rb'
end
 