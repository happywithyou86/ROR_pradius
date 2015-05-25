class UserSearch

	def self.find_all_users(user, text)
	#users = User.search(text, star: true, include: [:user_location] ).to_a
      users = User.find_all_by_prid(text)
   
   if users.blank?
    users_names = User.where("name LIKE ?" , "%#{text}%")
      if users_names.blank?
         location =  UserLocation.where("location LIKE ?" , "%#{text}%").collect{|p| p.user }
       end
      if location.blank?
      casino_id = Casino.where("downcased_name LIKE ?", "%#{text.downcase}%").to_a.collect(&:id)
	    end

    if !casino_id.blank?
       favorite_casino_user = FavoriteCasino.find_all_by_casino_id(casino_id).collect(&:user).to_a
	  end
       online_site_id = OnlineSite.where("downcased_name LIKE ?", "%#{text.downcase}%").to_a.collect(&:id)
    if !online_site_id.blank?
      favorite_online_user = FavoriteOnlineSite.find_all_by_online_site_id(online_site_id).collect(&:user)
    end
     if !users_names.blank?
       users << users_names
     elsif !location.blank?
       users << location
     elsif !favorite_casino_user.blank?
       users << favorite_casino_user
     elsif favorite_online_user
       users << favorite_online_user
     end
   end
	  return users.compact.flatten

	   # friend_ids = Friend.friend_ids_of_user(user)
	 
	    # forum_posts = ForumPost.includes(:forum_thread).where(user_id: friend_ids)

	    # threads = forum_posts.inject([]) do |result, forum_post|
	    #   result << forum_post.forum_thread
	    # end

	    # (threads + ForumThread.where(user_id: friend_ids).to_a).flatten.uniq{ |thread| thread.id }.sample(num)
	  end

end