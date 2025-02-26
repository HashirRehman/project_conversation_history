# frozen_string_literal: true

class Project < ApplicationRecord
  enum :status, { todo: 0, in_progress: 1, done: 2 }, prefix: true

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, length: { maximum: 200 }

  has_many :comments

  after_create_commit -> { broadcast_append_to "projects",
                           partial: "projects/project",
                           locals: { project: self }
  }
  after_update_commit :broadcast_status_update, if: -> { saved_change_to_status? }

  private

  def broadcast_status_update
    broadcast_replace_to "project_#{id}",
                         target: "project-status",
                         partial: "projects/status",
                         locals: { project: self }

    comments.create!(
      user: Current.user,
      text_content: "#{Current.user.name} updated the status from #{status_previously_was.humanize} to #{status.humanize}"
    )

    broadcast_append_to "project_#{id}_comments"
  end
end
