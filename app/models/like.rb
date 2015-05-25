# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  likeable_id   :integer
#  likeable_type :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:likeable_type, :likeable_id]

  class << self
    def find_likes_for_type type, id, user_id
      where(likeable_type: type, likeable_id: id, user_id: user_id).first
    end
  end

end
