class ActivityLikesController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create
    if current_user
      render :json => { likes: UserActivity.like_activity(params, current_user), id: params['id'], class: params['class'] }
    end
  end
end
