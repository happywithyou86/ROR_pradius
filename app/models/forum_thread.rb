# == Schema Information
#
# Table name: forum_threads
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  user_id          :integer
#  forum_section_id :integer
#  views            :integer          default(0)
#  created_at       :datetime
#  updated_at       :datetime
#

class ForumThread < ActiveRecord::Base
  belongs_to :forum_section

  has_many :forum_posts

  belongs_to :user

  accepts_nested_attributes_for :forum_posts, reject_if: lambda { |a| a[:message].blank? }

  def num_of_replies
    (self.forum_posts.count - 1).to_s
  end

  def increment_view!
    self.views = self.views + 1

    self.save
  end

  def self.new_with_build
    thread = self.new

    thread.forum_posts.build

    return thread
  end
end
