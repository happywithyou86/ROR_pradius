class SearchesController < ApplicationController
  before_action :redirect_non_signed_in_user

  include UsersHelper

  include SearchesHelper

  def results
    @data = {
        endorsements: Endorsement.where(endorsee_id: current_user.id).includes(:endorser).includes(:endorser => :user_profile_picture).to_a,
        users_in_area: PeopleSuggestion.find_local_users_in_area(current_user),
        users_from_casino: PeopleSuggestion.find_users_from_fav_casino(current_user),
        online_site_users: PeopleSuggestion.find_users_from_fav_site(current_user),
        interested_groups: DiscussionGroup.find_interested_groups(current_user, 7),
        users: UserSearch.find_all_users(current_user,params[:search_text])
      }
  end
end
