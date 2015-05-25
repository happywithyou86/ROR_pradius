# == Schema Information
#
# Table name: experiences
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  position        :string(255)
#  location        :string(255)
#  city            :string(255)
#  state           :string(255)
#  online_casino   :string(255)
#  nickname        :string(255)
#  description     :string(255)
#  present         :boolean
#  start_date      :datetime
#  end_date        :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  poker_room_id   :integer
#  poker_room_type :string(255)
#

class Experience < ActiveRecord::Base
  belongs_to :user
  belongs_to :poker_room, polymorphic: true

 # validates_uniqueness_of :user_id, :scope => [:poker_room_type, :poker_room_id]
 #validates_presence_of :position, :start_date

  scope :user_experiences, -> (user_id, poker_room_type) { where('user_id = ? AND poker_room_type = ?', user_id, poker_room_type) }
end
