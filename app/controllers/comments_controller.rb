# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)

    authorize_comment
    if @comment.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { redirect_to @comment.project, alert: "Error adding comment." }
      end
    end
  end

  def update
    authorize_comment
    if @comment.update(comment_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { redirect_to @comment.project, alert: "Error updating comment." }
      end
    end
  end

  def destroy
    authorize_comment
    @comment_id = @comment.id
    project = @comment.project
    unless @comment.destroy
      respond_to do |format|
        format.turbo_stream { redirect_to project }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment || Comment
  end

  def comment_params
    params.require(:comment).permit(:text_content, :user_id, :project_id)
  end
end
