# == Schema Information
#
# Table name: user_casino_event_types
#
#  id                   :integer          not null, primary key
#  user_online_event_id :integer
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class UserCasinoEventType < ActiveRecord::Base
  belongs_to :user_casino_event
end
