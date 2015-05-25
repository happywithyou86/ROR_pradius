# == Schema Information
#
# Table name: profile_visits
#
#  id              :integer          not null, primary key
#  profile_user_id :integer
#  visitor_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class ProfileVisit < ActiveRecord::Base
  belongs_to :profile_user, foreign_key: "profile_user_id", class_name: "User"

  belongs_to :visitor, foreign_key: "visitor_id", class_name: "User"

  validates :profile_user_id, uniqueness: { :scope => :visitor_id }
end
