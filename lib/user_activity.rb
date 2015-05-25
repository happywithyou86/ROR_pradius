class UserActivity
  # What will the activity feed pull?
  # =================================
  # 1) change in profile picture
  # 2) new endorsement
  # 3) new friendship formed
  # 4) user cash game created
  # 5) user casino event created
  # 6) change in user account details
  # 7) user wall message
  # 8) recommendation

  attr_reader :message, :created_at, :id, :klass, :liked, :comments
  def self.time_ago_in_words(start_time, include_seconds = false)
   diff_seconds = Time.now - start_time
   case diff_seconds
    when 0 .. 59
      return "#{diff_seconds.to_i} seconds ago"
    when 60 .. (3600-1)
      return "#{(diff_seconds/60).to_i} minutes ago"
    when 3600 .. (3600*24-1)
     return  "#{(diff_seconds/3600).to_i} hours ago"
    when (3600*24) .. (3600*24*30) 
      return "#{(diff_seconds/(3600*24)).to_i} days ago"
    else
     return  start_time.strftime("%m/%d/%Y")
   end
  end 
  def self.get_recent(user_id, current_user)
    user = User.find(user_id)

    # get friends_id
    friends_ids = Friend.where('user_id = ? OR friend_id = ?', user.id, user.id)
                        .pluck('user_id', 'friend_id')
                        .flatten
                        .delete_if { |id| id == user.id }

    # then get most recent activity in each model that includes the friends ids
    activities = []
  
    activities << UserProfilePicture.where(user_id: friends_ids).order("updated_at DESC").includes(:user).to_a

    activities << Endorsement.where('endorser_id in (?) or endorsee_id in (?)', friends_ids, friends_ids).order("created_at DESC").includes([:endorser, :endorsee]).to_a

    activities << Friend.where("user_id in (?) or friend_id in (?)", friends_ids, friends_ids).order("created_at DESC").includes([:user, :friend]).to_a

    activities << UserCashGame.where(user_id: friends_ids).order("created_at DESC").includes([:user, :location]).to_a

    activities << UserCasinoEvent.where(user_id: friends_ids).order("created_at DESC").includes([:user, :casino]).to_a

  #  activities << User.where(id: friends_ids).order("updated_at DESC").to_a

    activities << UserWallMessage.where("user_id in (?) or from_user_id in (?)", friends_ids, friends_ids).order("created_at DESC").includes([:user, :from_user]).to_a

    activities << Recommendation.where(user_id: friends_ids).order("created_at DESC").includes([:user, :poker_room]).to_a

    activities << ActivityLike.where(user_id: user.id).order("created_at DESC").to_a
    
    activities << ActivityComment.where(user_id: user.id).order("created_at DESC").to_a
    activities.flatten!.sort_by!(&:created_at).reverse!.compact

    # loop through recent activity and init a UserActivity instance
    user_activities = []
    activities.each do |activity|
      case activity
        when UserProfilePicture
          if !activity.nil? && !user.nil? && !current_user.nil? && !user.user_profile_picture.nil?
            user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_profile_picture(activity,user), activity.created_at, user.prid, user)
          end
        when Endorsement
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_endorsement(activity,user), activity.created_at, user.prid, user) if !UserActivity.format_endorsement(activity,user).blank?
        when Friend
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_friendship(activity,user), activity.created_at, user.prid, user)
        when UserCashGame
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user_cash_game(activity,user), activity.created_at, user.prid, user)
        when UserCasinoEvent
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user_casino_event(activity,user), activity.created_at, user.prid, user)
        when User
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user(activity,user), activity.created_at, user.prid, user)
        when UserWallMessage
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user_wall_message(activity,user), activity.created_at, user.prid, user)
        when Recommendation
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_recommendation(activity,user), activity.created_at, user.prid, user)
        when ActivityLike
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user_recent_likes(activity,user), activity.created_at, user.prid, user) if !UserActivity.format_user_recent_likes(activity,user).nil?
        when ActivityComment
          user_activities << UserActivity.new(activity.class, activity.id, UserActivity.format_user_recent_comment_on_post(activity,user), activity.created_at, user.prid, user) if  !UserActivity.format_user_recent_comment_on_post(activity,user).nil?

        else
        end
    end

    # Return all the UserActivities as objects in an array
    return user_activities
  end

  # format_ method will format the model and create a message for the new instance of UserActivity
  def self.format_profile_picture(model,user)
    if model.user.id == user.id
   # if model.user_id.present? && !model.user.name.blank? && !model.blank? && !model.user.blank?
      "#{model.user.name} has a new profile picture <br/> #{time_ago_in_words(model.created_at)}"
    #end
    end
  end

  def self.format_endorsement(model,user)
    if model.endorser.id == user.id
      if !model.endorsee.blank? && !model.endorser.blank?
       "#{model.endorser.name} has endorsed #{model.endorsee.name} <br/> #{model.message} <br/> #{time_ago_in_words(model.created_at)} "
      end
   end 
  end

  def self.format_friendship(model,user)
     if model.try(:user).try(:id) == user.try(:id)
     if !model.user.nil? && !model.friend.nil?
      "#{model.user.name} connected with  #{model.friend.name} <br/> #{time_ago_in_words(model.created_at)}"
     end
   end
  end

  def self.format_user_cash_game(model ,user)
      if model.user.id == user.id
        if !model.user.name.nil?
          "#{model.user.name} was in a cash game at #{model.location.name} in #{model.location.location_as_s} <br/> #{time_ago_in_words(model.created_at)}"
        end
      end
  end

  def self.format_user_casino_event(model,user)
   if model.user.id == user.id
    if !model.user.name.nil?   && !model.casino.nil?
     "#{model.user.name} was at the #{model.casino.name} in #{model.casino.location_as_s} <br/> #{time_ago_in_words(model.created_at)}"
    end
  end
  end

  def self.format_user(model,user)
     if model.user.id == user.id
       if !model.name.nil?
        "#{model.name} has updated their profile <br/> #{time_ago_in_words(model.created_at)}"
      end
    end
  end

  def self.format_user_wall_message(model,user)
    if model.from_user.id == user.id
      if !model.from_user.nil? && !model.user.nil?
        "#{model.from_user.name} has posted on #{model.user.name}'s wall <br/>  #{time_ago_in_words(model.created_at)}"
      end
    end
  end

  def self.format_recommendation(model,user)
     if model.user.id == user.id
      if !model.nil? && !model.user.nil? && !model.poker_room_type.nil? && !model.poker_room.nil? 
        "#{model.user.name} has recommended a #{model.poker_room_type} at #{model.poker_room.name} <br/> #{time_ago_in_words(model.created_at)}"
      end
    end
  end
  def self.format_user_recent_likes(model,user)
   if model.user.id == user.id
    if model.klass_name == "Post"
      post= Post.find_by_id(model.klass_id)
      if !model.user.blank? && !post.blank? && !post.user.blank? 
      "#{model.user.name} liked a comment by #{post.user.name} <br/> #{post.status} <br/> #{time_ago_in_words(post.created_at)}"
     end
    end
    end
  end

  def self.format_user_recent_comment_on_post(model,user)
  if model.user.id == user.id
   if model.klass_name == "Comment"
     comment= Comment.find(model.klass_id)
     post= Post.find_by_id(comment.commentable_id)
     if !comment.commentable.blank? && !post.blank?
       "#{model.user.name}  commented on a post by #{comment.commentable.user.name} <br/>   #{post.status}  <br/> #{time_ago_in_words(comment.created_at)}"
     end
    end
  end
  end
  def self.find_activity_record(params)
    model = nil

    case params["class"].to_s
      when "UserProfilePicture"
        model = UserProfilePicture.find(params["id"].to_i)
      when "Endorsement"
        model = Endorsement.find(params["id"].to_i)
      when "Friend"
        model = Friend.find(params["id"].to_i)
      when "UserCashGame"
        model = UserCashGame.find(params["id"].to_i)
      when "UserCasinoEvent"
        model = UserCasinoEvent.find(params["id"].to_i)
      when "User"
        model = User.find(params["id"].to_i)
      when "UserWallMessage"
        model = UserWallMessage.find(params["id"].to_i)
      when "Recommendation"
        model = Recommendation.find(params["id"].to_i)
      else
    end

    return model
  end

  def self.like_activity(params, current_user)
    model = find_activity_record(params)

    if model
      activity_likes = ActivityLike.where(klass_id: model.id, klass_name: model.class.to_s)

      if activity_likes.where(user_id: current_user.id).first
        activity_likes.count
      else
        # We increment and return model likes
        ActivityLike.create(klass_id: model.id, klass_name: model.class.to_s, user_id: current_user.id)

        activity_likes.count
      end
    else
      ""
    end
  end

  def self.find_likes(klass, id, prid, current_user)
    liked = nil

    model = find_activity_record({"class" => klass, "id" => id})

    if current_user
      user = User.where("prid = ?", prid.to_s).first

      liked = ActivityLike.where("user_id = ? AND klass_id = ? AND klass_name = ?", user.id, id, klass).first
    end

    if model
      likes = ActivityLike.where("klass_id = ? AND klass_name = ?", id, klass).count

      liked ? "Liked (#{likes})" : "Like (#{likes})"
    else
      false
    end
  end

  def initialize(klass, id, message, created_at, prid, current_user)
    @klass = klass

    @id = id

    @message = message

    @created_at = created_at

    @liked = UserActivity.find_likes(klass, id, prid, current_user)

    @comments = ActivityComment.includes(:user).where(klass_name: klass, klass_id: id).order("created_at DESC").to_a
  end

end
