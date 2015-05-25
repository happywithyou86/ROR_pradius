class CasinosController < ApplicationController
  before_action :redirect_non_signed_in_user

  def index
    @casinos = Casino.all
  end

  def show
    @recommendation = Recommendation.new_with_built_associations

    @casino = Casino.find(params[:id])

    @casino_recommendations = @casino.recommendations.includes(:recommendation_comment)
  end

  def recommend
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      flash[:success] = "Recommendation saved."

      redirect_to "/casinos/#{@recommendation.poker_room_id}"
    else
      @casino = Casino.find(recommendation_params["poker_room_id"])

      @casino_recommendations = @casino.recommendations.includes(:recommendation_comment)

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
