# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :text_content, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :user
  belongs_to :project

  after_create_commit do
    broadcast_append_to(
      "project_#{project.id}_comments",
      target: "comments",
      partial: "comments/comment",
      locals: { comment: self, action_type: "added" }
    )
  end

  after_update_commit do
    broadcast_replace_to(
      "project_#{project.id}_comments",
      target: "comment_#{id}",
      partial: "comments/comment",
      locals: { comment: self, action_type: "updated" }
    )
  end

  after_destroy_commit do
    broadcast_replace_to(
      "project_#{project.id}_comments",
      target: "comment_#{id}",
      partial: "comments/deleted_notice",
      locals: { id: id }
    )
  end
end
