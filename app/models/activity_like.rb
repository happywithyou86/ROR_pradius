# == Schema Information
#
# Table name: activity_likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  klass_id   :integer
#  klass_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ActivityLike < ActiveRecord::Base
  belongs_to :user
end
