# == Schema Information
#
# Table name: activity_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  klass_name :string(255)
#  klass_id   :integer
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

class ActivityComment < ActiveRecord::Base
  belongs_to :user
end
