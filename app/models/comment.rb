# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :text_content, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :user
  belongs_to :project

  after_create_commit do
    broadcast_append_to "project_#{project.id}_comments", target: "comments"
  end
end
