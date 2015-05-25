# == Schema Information
#
# Table name: casinos
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  url            :text
#  created_at     :datetime
#  updated_at     :datetime
#  downcased_name :string(255)
#

class Casino < ActiveRecord::Base

  has_many :favorite_casinos

  has_many :user_casino_events

  has_many :user_cash_games, as: :location

  has_many :user_tournaments, as: :location

  has_many :recommendations, as: :poker_room
  has_many :experiences, as: :poker_room

  validates_uniqueness_of :downcased_name

  before_validation :downcase_name

  before_create :validate_url


  # validates :url, uniqueness: true

  def self.all_as_array
    first_casino =Casino.where('lower(name) like lower(?)', "%i don't play poker in casinos%")
    if !first_casino.blank?
      casinos  =  Casino.all.collect{|c| c if c.id != first_casino.first.id}.compact
   
    end
  if ! casinos.blank?

    casinos = casinos.sort_by(&:downcased_name) 
    casinos_as_array = []
    if !first_casino.blank?
       casinos_as_array << [first_casino.first.name, first_casino.first.id]
    end
    casinos.each do |casino|
     
      casinos_as_array << [casino.name, casino.id]
    end
    end
    return casinos_as_array


  end

  def location_as_s
     "#{self.city}, #{self.state}"
  end

  private
    def downcase_name
      self.downcased_name = name.downcase
    end

    def validate_url
    if !url.nil?
      if !url.include?('http://') || !url.include?('https://')
        self.url = 'http://' + url
      end
     end
    end
end
