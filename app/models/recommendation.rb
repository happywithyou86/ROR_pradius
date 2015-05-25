# == Schema Information
#
# Table name: recommendations
#
#  id              :integer          not null, primary key
#  poker_room_type :string(255)
#  poker_room_id   :integer
#  user_id         :integer
#  rating          :integer
#  created_at      :datetime
#  updated_at      :datetime
#  comment         :string(255)
#  room_name       :string(255)
#

class Recommendation < ActiveRecord::Base
  has_one :recommendation_comment

  belongs_to :user

  belongs_to :poker_room, polymorphic: true

  validates_presence_of :room_name
  validates_uniqueness_of :user_id, :scope => [:poker_room_type, :poker_room_id]

  validates :rating, presence: true

  accepts_nested_attributes_for :recommendation_comment

  scope :user_achievements, -> (user_id, poker_room_type) { where('user_id = ? AND poker_room_type = ?', user_id, poker_room_type) }


  def self.new_with_built_associations
    recommendation = Recommendation.new

    recommendation.build_recommendation_comment

    return recommendation
  end
end
