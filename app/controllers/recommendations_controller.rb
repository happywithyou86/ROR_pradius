class RecommendationsController < ApplicationController
  before_action :redirect_non_signed_in_user



  def create
    poker_room = find_or_create_poker_room(params[:recommendation][:poker_room_type], params[:recommendation][:room_name], params[:url])
    params[:recommendation].merge!(poker_room_id: poker_room.id)
    current_user.recommendations.create(recommendation_params)
    online_recommendations = Recommendation.user_achievements(current_user.id, 'OnlineSite')
    casino_recommendations = Recommendation.user_achievements(current_user.id, 'Casino')
    if params[:recommendation][:poker_room_type] == "OnlineSite"
      render json: render_to_string( :partial => '/users/recommendations_online', :locals => { :online_recommendations => online_recommendations } ).to_json, status: :ok
    else
      render json: render_to_string( :partial => '/users/recommendations_casino', :locals => {  :casino_recommendations => casino_recommendations } ).to_json, status: :ok
    end
  end

  def edit
    recommendation = Recommendation.find(params[:rec_id])
    render json: { partial: render_to_string( partial: '/recommendations/edit_recommendation', locals: {recommendation: recommendation}), rec_id: recommendation.id }, status: :ok
  end

  def update
    #  Will have to Edit gratley to incorporate Poker Room changes and then uncomment on recommendation page
    recommendation = Recommendation.find(params[:recommendation][:recId])
    params[:recommendation].except!(:recId)
    recommendation.update_attributes(recommendation_params)
    render json: { partial: render_to_string( partial: '/recommendations/recommendation', locals: {recommendation: recommendation}), rec_id: recommendation.id }, status: :ok
  end

  def destroy
    rec_id = params[:rec_id]
    recommendation = Recommendation.find(rec_id)
    recommendation.destroy
    render json: {rec_id: rec_id}, status: :ok
  end

  def suggestions
    current_user = User.find(params[:current_user])

    @data = {
      users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
      users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
      online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
      interested_groups: DiscussionGroup.find_interested_groups(current_user, 5)
    }

    case params[:used_for]
      when "common_users"
        @users = PeopleSuggestion.find_common_users(current_user, User.find(params[:profile_user])).flatten.each_slice(20).to_a
      when "casino_users"
        @users = PeopleSuggestion.find_users_from_fav_casino(current_user).flatten.each_slice(20).to_a
      when "online_site_users"
        @users = PeopleSuggestion.find_users_from_fav_site(current_user).flatten.each_slice(20).to_a
      when "local_users"
        @users = PeopleSuggestion.find_local_users_in_area(current_user).flatten.each_slice(20).to_a
      when "other_viewers"
        @users = PeopleSuggestion.find_other_profile_visitors(current_user, User.find(params[:profile_user])).flatten.each_slice(20).to_a
    end
  end


  private
    def recommendation_params
      params.require(:recommendation).permit(:user_id, :rating, :poker_room_type, :room_name, :poker_room_id, :comment)
    end

    def find_or_create_poker_room klass, name, url
      klass.constantize.find_by_downcased_name(name.downcase) || klass.constantize.create(name: name, url: url)
    end
end
