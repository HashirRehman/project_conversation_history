# frozen_string_literal: true

class Project < ApplicationRecord
  
  validates :title, presence :true, length: { minimum: 10, maximum: 20 }
  validates :descritpion, length: { maximum: 200 }

  enum status: { todo: 0, in_progress: 1, done: 2 }, prefix: true

  has_many :comments
end