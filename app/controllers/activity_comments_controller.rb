class ActivityCommentsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create
    ActivityComment.create(activity_comment_params)

    render :nothing => true
  end

  def activity_comment_params
    params[:activity_comment][:user_id] = current_user.id

    params.require(:activity_comment).permit(:comment, :user_id, :klass_name, :klass_id)
  end
end
