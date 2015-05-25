# == Schema Information
#
# Table name: suspended_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class SuspendedUser < ActiveRecord::Base
  belongs_to :user

  before_destroy :check_user

  def check_user
    user = User.find(self.user_id)
    user.login_attempt = 0
    user.save
  end



end
