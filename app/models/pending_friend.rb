# == Schema Information
#
# Table name: pending_friends
#
#  id               :integer          not null, primary key
#  requester_id     :integer
#  requestee_id     :integer
#  how_you_know_him :string(255)
#  message          :text
#  created_at       :datetime
#  updated_at       :datetime
#

class PendingFriend < ActiveRecord::Base
  belongs_to :requester, foreign_key: "requester_id", class_name: "User"
  belongs_to :requestee, foreign_key: "requestee_id", class_name: "User"


  validates_uniqueness_of :requestee_id, :scope => :requester_id



  after_create :send_notification


  class << self
    def friend_requests_for_user user
      where('requestee_id = ?', user.id).includes(:requestee).includes(:requestee => :user_profile_picture).includes(:requestee => :user_location).to_a.reverse
    end
  end

  def send_notification
    self.requestee.notify('new_friend_request', 'friend', @pending_friend)
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
