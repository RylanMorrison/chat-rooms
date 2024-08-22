# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description

      t.timestamps
    end
  end
end
