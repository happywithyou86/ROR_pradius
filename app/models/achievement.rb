# == Schema Information
#
# Table name: achievements
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  description   :string(255)
#  online_casino :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Achievement < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :description
end
