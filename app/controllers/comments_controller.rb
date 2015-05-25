class CommentsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def create
    comment = Comment.create(comment_params)
    if current_user.opt_in == true
     UserMailer.user_comment(comment.commentable.user, comment.user, comment.text)
    end
    ActivityComment.create(user_id: current_user.id,klass_id: comment.id,klass_name: "Comment",comment:comment.text) 
    render json: render_to_string( partial: '/comments/comment', locals: { comment: comment } ).to_json, status: :ok
  end

  def like
  end

  def delete
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id, :commentable_id, :commentable_type)
    end
end
