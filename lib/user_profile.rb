class UserProfile

  def self.get(prid, current_user)
    # Get user
    user = User.includes([:user_facebook, :user_location, :user_nickname, :user_profile_picture, :user_subscription, :user_twitter, :user_blog]).find_by_prid(prid)

    if user

      user.build_user_location if user.user_location.blank?

      # Find friends
      friends = Friend.where('user_id = ? OR friend_id = ?', user.id, user.id).includes([:friend, :user]).to_a

      {
        user: user,
        friends: friends,
        pending_friend: PendingFriend.new,
        users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
        user_recent_activity: UserActivity.get_recent(user.id, current_user),
        countries: Country.all.to_a,
        users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
        online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
        interested_groups: DiscussionGroup.find_interested_groups(current_user, 5),
        common_users: PeopleSuggestion.find_common_users(current_user, user),
        other_viewers: PeopleSuggestion.find_other_profile_visitors(current_user, user),
        online_experiences: Experience.user_experiences(user.id, 'OnlineSite'),
        casino_experiences: Experience.user_experiences(user.id, 'Casino'),
        online_achievements: Achievement.where('user_id = ? AND online_casino = ?', user.id, 'online'),
        casino_achievements: Achievement.where('user_id = ? AND online_casino = ?', user.id, 'casino'),
        endorsements: Endorsement.where(endorsee_id: user.id).includes(:endorser).includes(:endorser => :user_profile_picture).to_a,
        online_recommendations: Recommendation.user_achievements(user, 'OnlineSite'),
        casino_recommendations: Recommendation.user_achievements(user, 'Casino')
      }
    else
      false
    end
  end

  def self.visited_site(current_user, profile_user)
    if current_user.id != profile_user.id
      ProfileVisit.create(visitor_id: current_user.id, profile_user_id: profile_user.id)
    end

    return true
  end
end
