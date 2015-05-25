class PeopleSuggestion

  def self.find_recommended_friends user
    record_count = 9
    recommendations = {} #Will store the point system for friends of friends

    friends = Friend.friend_ids_of_user(user)
    rejectList = friends #Do not recommend friends
    rejectList << user.id #Do not recommend self
    #Get Friends of Friends

    usersFriends = Friend.friend_ids_of_user(User.find(user.id)).first(15)
    friendsLevel2 = find_next_level_friends(usersFriends, 15)
    friendsLevel2 = friendsLevel2 - rejectList #Do not add freinds and self

    friendsLevel3 = find_next_level_friends(friendsLevel2, 8)
    friendsLevel3 = friendsLevel3 - rejectList #Do not add freinds and self

    friendsLevel4 = find_next_level_friends(friendsLevel3, 4)
    friendsLevel4 = friendsLevel4 - rejectList #Do not add freinds and self

    #Weight the friends in friend levels
    givePoints(recommendations, friendsLevel2, 1)
    givePoints(recommendations, friendsLevel3, 0.6)
    givePoints(recommendations, friendsLevel4, 0.275)

    sortedRecommendation = recommendations.keys.sort { |a, b| recommendations[b] <=> recommendations[a]}.first(record_count)

    return filter_by_profile_pic(User.find(sortedRecommendation))
  end

  def self.find_local_users_in_area(user)
    record_count = 9
    if !user.user_location.blank? && !user.user_location.postal_code.blank? 
    zip = user.user_location.postal_code 
    local_users = []
    if zip != nil
    #  prefix = zip[0..2]
      prefix = zip
     # local_users = UserLocation.where("postal_code like ?", "#{prefix}").map { |location| location.user }.compact.sample(record_count)
      local_users  =  UserLocation.find_all_by_postal_code(prefix).collect{|p| p.user }.compact

    end

   # if local_users.length <= record_count
  
      #User.first(100).sample(record_count - local_users.length).each do |user|
      #  User.all.each do |user|
      #   if !user.user_location.blank?  && !user.user_location.postal_code.blank?  &&  user.user_location.postal_code == prefix
      #     local_users << user 
      #   end
      # end
  #  end
    
    filter_by_profile_pic(local_users.first(9))


    # user_location = user.user_location


    # if user and user_location.present?
    #   # users_in_local_area = UserLocation.within(35, origin: [user_location.latitude, user_location.longitude]).to_a
    #   users_in_local_area = UserLocation.near([user_location.latitude, user_location.longitude], 35)

    #   filtered_users = []

    #   users_in_local_area.each do |local_user|
    #     # Remove own user from local users because
    #     # it's silly to think suggested friends would include YOURSELF!
    #     unless user.id == local_user.user_id
    #       filtered_users << User.includes([:user_profile_picture]).find(local_user.user_id)
    #     end
    #   end

    #   # Sort by who does and doesn't have a profile pic
    #   filter_by_profile_pic(filtered_users)

    # else
    #   # What do I do if user hasn't set a user location?
    # end

  end
  end

  def self.find_users_from_fav_casino(user)
    if user.favorite_casino.present? && !user.favorite_casino.casino.nil?
       casino = user.favorite_casino.casino
      
      ids = ["favorite_casinos", "user_casino_events", "user_cash_games", "user_tournaments", "recommendations"].inject([]) do |ids, method|

        ids << casino.send(method).map { |x| x[:user_id]  if !x[:user_id].nil? }
      end.flatten.uniq

      filter_by_profile_pic(User.includes([:user_profile_picture]).where(id: ids).to_a)
    else
      # What to do with no fav casino
    end
  end

  def self.find_users_from_fav_site(user)
    if user.favorite_online_site.present? && !user.favorite_online_site.online_site.nil?
      online_site = user.favorite_online_site.online_site

      ids = ["favorite_online_sites", "user_cash_games", "user_tournaments", "user_online_events", "recommendations"].inject([]) do |ids, method|
        ids << online_site.send(method).map { |x| x[:user_id] if !x[:user_id].nil?}
      end.flatten.uniq

      filter_by_profile_pic(User.includes([:user_profile_picture]).where(id: ids).to_a)
    else
      # What to do with no fav casino
    end
  end

  def self.find_common_users(current_user, user)
    common_friends = (Friend.friend_ids_of_user(user) & Friend.friend_ids_of_user(current_user))

    filter_by_profile_pic(User.includes(:user_profile_picture).where(id: common_friends).to_a)
  end

  def self.find_other_profile_visitors(current_user, user)
    visitors = []
   
    ProfileVisit.includes(:visitor).where(profile_user_id: user.id).to_a.each do |visit|
    
      if !visit.visitor.nil? && current_user.present?
        visitors << visit.visitor 
      end
    end

    filter_by_profile_pic(visitors)
  end

  def self.filter_by_profile_pic(users)
   users = users.sort_by{|local_user| local_user.user_profile_picture.present?  }.compact.reverse
  # sorted_users = []
   #users.each do |user|
    # if user.user_profile_picture.present?
    #sorted_users << user
     #end
   #end

    #sorted_users = sorted_users.sort_by{|local_user| local_user.user_profile_picture.present? }.reverse

   return users.each_slice(3).to_a
  end

  private
 # def self.getNextLevelFriends user_id, limit
  #  Friend.friend_ids_of_user(User.find(friend_id)).first(8)

  def self.find_next_level_friends friends, limit
    nextLevelFriends = []
    for friend_id in friends
      nextLevelFriends = nextLevelFriends + Friend.friend_ids_of_user(User.find(friend_id)).first(limit)
    end

    return nextLevelFriends
  end

  def self.givePoints recommendations, friends, weight
    for friend_id in friends
      if recommendations[friend_id] == nil
        recommendations[friend_id] = weight
      else
        recommendations[friend_id] += weight
      end
    end
  end
end
