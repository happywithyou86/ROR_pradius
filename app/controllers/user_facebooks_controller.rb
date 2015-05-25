class UserFacebooksController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create_or_update
    UserFacebook.find_or_create_by(user_id: current_user.id).update_attributes(url: params[:user_facebook][:url])

    render :nothing => true
  end
end
