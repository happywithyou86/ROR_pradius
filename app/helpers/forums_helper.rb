module ForumsHelper
  def last_post(last_post)
    if last_post.present? && !last_post.user.blank?
      link_to(last_post.user.name, "/#{last_post.user.id}") + "<br>".html_safe + content_tag(:span, time_ago(last_post.created_at))
    else
      content_tag(:span, "No posts yet.")
    end

  end
end