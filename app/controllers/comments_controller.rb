# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    authorize_comment
    if @comment.save!
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream {  redirect_to @comment.project, alert: "Error adding comment." }
      end
    end
  end

  private

  def authorize_comment
    authorize @comment || Comment
  end

  def comment_params
    params.require(:comment).permit(:text_content, :user_id, :project_id)
  end
end
