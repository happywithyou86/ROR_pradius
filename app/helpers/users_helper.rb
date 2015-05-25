module UsersHelper
  def create_profile_pic(user, size = '200', responsive = true)
    if !user.nil?
      if user.user_profile_picture.present? && !user.user_profile_picture.url.blank?
        link_to image_tag(user.user_profile_picture.url, width: size.to_s + 'px', height: size.to_s + 'px' , class: "#{responsive ? "img-responsive" : ""}"), "/#{user.prid}"
      else
        link_to image_tag('blank-profile.png', width: size.to_s + 'px', height: size.to_s + 'px', class: "#{responsive ? "img-responsive" : ""}"), "/#{user.prid}"
      end

    end
  end

  def users_are_friends? user
    current_user.is_friends_with?(user)
  end

  def current_users_profile? user
    current_user == user
  end

end
