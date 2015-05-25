# == Schema Information
#
# Table name: user_locations
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  location    :string(255)      default("")
#  country_id  :integer          default(1)
#  postal_code :string(255)
#  latitude    :float
#  longitude   :float
#  hide_city   :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class UserLocation < ActiveRecord::Base
  belongs_to :user

  #before_create :update_coordinates

  belongs_to :country

 # validates :user_id, uniqueness: true

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  geocoded_by :postal_code


  def update_coordinates
    if self.changed?
      begin
        result = Geocoder.search("#{self.location unless self.location.present?} #{self.postal_code if self.postal_code.present?}")
      rescue
      else
        if result.present?
          self.latitude = result.first.latitude
          self.longitude = result.first.longitude
          self.location = result.first.city
          self.state_and_city = result.first.city + " " + result.first.state_code if !result.first.city.nil? && !result.first.state_code.nil?
          country = Country.where('name LIKE ?', "%#{result.first.country}%")
          self.country_id = country.first.id if !country.nil?
        elsif result.blank? 
          return false
        end
      end
    end
  end

  def get_address
    self.location
  end
end
