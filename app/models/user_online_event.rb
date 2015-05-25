# == Schema Information
#
# Table name: user_online_events
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  hours_played   :integer
#  place_taken    :integer
#  online_site_id :integer
#  prize          :float
#  comment        :text
#  created_at     :datetime
#  updated_at     :datetime
#

class UserOnlineEvent < ActiveRecord::Base
  belongs_to :user

  belongs_to :online_site

  has_one :user_online_event_type



end
