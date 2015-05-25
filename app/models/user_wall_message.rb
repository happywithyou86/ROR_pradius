# == Schema Information
#
# Table name: user_wall_messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  message      :text
#  from_user_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UserWallMessage < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id", class_name: "User"

  belongs_to :from_user, foreign_key: "from_user_id", class_name: "User"

end
