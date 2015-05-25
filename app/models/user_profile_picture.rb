# == Schema Information
#
# Table name: user_profile_pictures
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UserProfilePicture < ActiveRecord::Base
  belongs_to :user

end
