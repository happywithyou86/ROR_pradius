class DiscussionGroup
  def self.find_interested_groups(user, num)
    # friend_ids = Friend.friend_ids_of_user(user)
   
    # forum_posts = ForumPost.includes(:forum_thread).where(user_id: friend_ids)

    # threads = forum_posts.inject([]) do |result, forum_post|
    #   result << forum_post.forum_thread
    # end

    # (threads + ForumThread.where(user_id: friend_ids).to_a).flatten.uniq{ |thread| thread.id }.sample(num)
    threads =ForumThread.limit(5).order('id desc')

  end
end