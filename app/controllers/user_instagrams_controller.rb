class UserInstagramsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create_or_update
    UserInstagram.find_or_create_by(user_id: current_user.id).update_attributes(url: params[:user_instagram][:url])

    render :nothing => true
  end
end
