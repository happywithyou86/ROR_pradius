class SearchForum
  def self.thread(search_term, thread, page)
    posts = ForumPost.where(forum_thread_id: thread.id).where("message ILIKE ?", "%#{search_term}%").paginate(page: page, per_page: 12).to_a

    return posts
  end

  def self.threads(search_term, section, page)
     threads = ForumThread.where("name ILIKE ?", "%#{search_term}%").where(forum_section_id: section.id).paginate(page: page, per_page: 12).to_a
  end
end
