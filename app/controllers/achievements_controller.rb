class AchievementsController < ApplicationController

  def create
    current_user.achievements.create(:description=>params['description'],:online_casino=>params["online_casino"])
    online_achievements = Achievement.where('user_id = ? AND online_casino = ?', current_user.id, 'online')
    casino_achievements = Achievement.where('user_id = ? AND online_casino = ?', current_user.id, 'casino')
    render json: render_to_string( :partial => '/users/achievements', :locals => {:online_achievements => online_achievements, :casino_achievements => casino_achievements}).to_json, status: :ok
  end

  def edit
    achievement = Achievement.find(params[:ach_id])
    render json: { partial: render_to_string( partial: '/achievements/edit_achievement', locals: {achievement: achievement}), ach_id: achievement.id }, status: :ok
  end

  def update
    achievement = Achievement.find(params[:achievement][:ach_id])
    params[:achievement].except!(:ach_id)
    achievement.update_attributes(achievement_params)
    render json: { partial: render_to_string( partial: '/achievements/achievement', locals: {achievement: achievement }), ach_id: achievement.id }, status: :ok
  end

  def destroy
    achievement = Achievement.find(params[:ach_id])
    ach_id = achievement.id
    achievement.destroy
    render json: {ach_id: ach_id}, status: :ok
  end

  private

    def achievement_params
      params.require(:achievement).permit!
    end
end
