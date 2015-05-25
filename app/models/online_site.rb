# == Schema Information
#
# Table name: online_sites
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :text
#  created_at     :datetime
#  updated_at     :datetime
#  downcased_name :string(255)
#

class OnlineSite < ActiveRecord::Base
  has_many :favorite_online_sites

  has_many :user_cash_games, as: :location

  has_many :user_tournaments, as: :location

  has_many :user_online_events

  has_many :recommendations, as: :poker_room
  has_many :experiences, as: :poker_room

  validates_uniqueness_of :downcased_name

  before_validation :downcase_name

  before_create :validate_url

  def self.all_as_array

  first_online_site =OnlineSite.where('lower(name) like lower(?)', "%i don't play poker online%")
   if !first_online_site.blank?
      online_sites  =  OnlineSite.all.collect{|o| o if o.id != first_online_site.first.id}.compact
    end

     if ! online_sites.blank?
    online_sites = online_sites.sort_by(&:downcased_name) 

    online_sites_as_array = []
    if !first_online_site.blank?
       online_sites_as_array << [first_online_site.first.name, first_online_site.first.id]
    end
    online_sites.each do |online_site|
      online_sites_as_array << [online_site.name, online_site.id]
    end
end
    return online_sites_as_array

  end

  private
    def downcase_name
      self.downcased_name = name.downcase
    end

    def validate_url
      if !url.blank? && !url.nil?
        if !url.include?('http://') || !url.include?('https://')
          self.url = 'http://' + url
        end
      end
    end
end
