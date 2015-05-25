# == Schema Information
#
# Table name: user_nicknames
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  location_type :string(255)
#  location_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class UserNickname < ActiveRecord::Base
  belongs_to :user

end
