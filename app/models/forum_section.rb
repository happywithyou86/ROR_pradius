# == Schema Information
#
# Table name: forum_sections
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  forum_id    :integer
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class ForumSection < ActiveRecord::Base
  has_many :forum_threads
  belongs_to :forum

  def num_of_threads
    ForumThread.where(forum_section_id: self.id).count.to_s
  end

  def num_of_posts
    ForumThread.where(forum_section_id: self.id).pluck(:id).to_a.inject(0) do |result, id|
      result += ForumPost.where(forum_thread_id: id).count
    end.to_s
  end

  def last_post
    ForumPost.where(forum_thread_id: ForumThread.where(forum_section_id: self.id).pluck(:id).to_a)
             .order("created_at")
             .includes([:user, :forum_thread])
             .last
  end
end
