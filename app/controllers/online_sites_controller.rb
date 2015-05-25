class OnlineSitesController < ApplicationController
  before_action :redirect_non_signed_in_user

  def index
    @online_sites = OnlineSite.all
  end

  def show
    @recommendation = Recommendation.new_with_built_associations

    @online_site = OnlineSite.find(params[:id])

    @online_site_recommendations = @online_site.recommendations.includes(:recommendation_comment)
  end

  def recommend
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      flash[:success] = "Recommendation saved."

      redirect_to "/online_site/#{@recommendation.poker_room_id}"
    else
      @online_site = OnlineSite.find(recommendation_params["poker_room_id"])

      @online_site_recommendations = @online_site.recommendations.includes(:recommendation_comment)

      render "show"
    end
  end

  private

  def recommendation_params
    params[:recommendation][:user_id] = current_user.id

    params.require(:recommendation).permit(:user_id, :rating, :poker_room_type, :poker_room_id,
                                           recommendation_comment_attributes: :comment)
  end
end


