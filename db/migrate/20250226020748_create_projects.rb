# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
