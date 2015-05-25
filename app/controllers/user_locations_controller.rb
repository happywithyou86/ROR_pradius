class UserLocationsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def update
    if current_user.id.to_s == user_location_params[:user_id]
      UserLocation.where(user_id: user_location_params[:user_id]).first.update_attributes(user_location_params)
    end

    render :nothing => true
  end

  private

  def user_location_params
    params.require(:user_location).permit(:user_id, :country_id)
  end
end
