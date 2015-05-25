# == Schema Information
#
# Table name: denied_friends
#
#  id           :integer          not null, primary key
#  requestee_id :integer
#  requester_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class DeniedFriend < ActiveRecord::Base
  belongs_to :requestee, foreign_key: "requestee_id", class_name: "User"
  belongs_to :requester, foreign_key: "requester_id", class_name: "User"


  class << self
    def create_denied_friendship user, friend
      find_or_create_by(
        requester_id: user.id,
        requestee_id: friend.id
      )
    end
  end

  class << self
    def denied_requests_for_user user
      where('requestee_id = ?', user.id).includes(:requestee).includes(:requestee => :user_profile_picture).includes(:requestee => :user_location).to_a.reverse
    end
  end
  def accept!
    Friend.create_friendship(self.requester, self.requestee)
    self.destroy
  end

  def ignore!
    DeniedFriend.create_denied_friendship(self.requester, self.requestee)
    self.destroy
  end

end
