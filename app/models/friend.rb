# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Friend < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id", class_name: "User"

  belongs_to :friend, foreign_key: "friend_id", class_name: "User"

  validates :user_id, uniqueness: { :scope => :friend_id }

  # returns friend objects that user is associated with
  # scope :friends_of_user, lambda { |user| where(["user_id = :user OR friend_id = :user", :user => user.id]) }

  class << self

    #returns array of user IDs that the user is friends with
    def friend_ids_of_user user
      Friend.where('user_id = ? OR friend_id = ?', user.id, user.id).pluck('user_id', 'friend_id').flatten.delete_if { |id| id == user.id }
    end

    def find_friendship friend_id, user_id
      where("user_id = ? OR friend_id = ? AND user_id = ? OR friend_id = ?", friend_id, friend_id, user_id, user_id).first
    end

    def create_friendship user, friend
     
      find_or_create_by(
        user_id: user.id,
        friend_id: friend.id
        # TODO friends: created accepted at for friendship
        # :accepted_at => Time.now
      )
    end
  end

end
