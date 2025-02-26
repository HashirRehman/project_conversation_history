# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :text_content, presence: true, length: { minimum: 3, maximum: 200 }

  belongs_to :user
  belongs_to :project
end