# == Schema Information
#
# Table name: user_casino_events
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  casino_id    :integer
#  hours_played :integer
#  place_taken  :integer
#  prize        :float
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class UserCasinoEvent < ActiveRecord::Base
  belongs_to :user

  belongs_to :casino

  has_one :user_casino_event_type
end
