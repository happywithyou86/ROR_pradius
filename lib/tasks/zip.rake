namespace :geocoder do
  desc "Geocode all objects without coordinates."
  task :all_with_retry => :environment do
    class_name = ENV['CLASS'] || ENV['class']
    sleep_timer = ENV['SLEEP'] || ENV['sleep']
    raise "Please specify a CLASS (model)" unless class_name
    klass = class_from_string(class_name)
 
    klass.not_geocoded.each do |obj|
      geocode_with_retry obj
      sleep(sleep_timer.to_f) unless sleep_timer.nil?
    end
  end
end
 
def geocode_with_retry(obj)
  tries ||= 3
  puts "Trying again, #{tries} tries left..." if tries < 3
  puts Time.now.strftime("%Y%m%d%H%M%S")+": Geocoding " + obj.to_s
  obj.geocode
  if obj.geocoded?
    obj.save
  else
    sleep(3.0/tries) #Back off in 1s, 2s, 3s intervals
    raise Geocoder::OverQueryLimitError
  end 
  rescue Geocoder::OverQueryLimitError => e
    retry unless (tries -= 1).zero?
end
 
##
# Get a class object from the string given in the shell environment.
# Similar to ActiveSupport's +constantize+ method.
#
def class_from_string(class_name)
  parts = class_name.split("::")
  constant = Object
  parts.each do |part|
    constant = constant.const_get(part)
  end
  constant
end