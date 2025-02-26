# frozen_string_literal: true

class Project < ApplicationRecord
  after_create_commit -> { broadcast_append_to "projects", partial: "projects/project", locals: { project: self } }

  enum :status, { todo: 0, in_progress: 1, done: 2 }, prefix: true

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, length: { maximum: 200 }

  has_many :comments
end
