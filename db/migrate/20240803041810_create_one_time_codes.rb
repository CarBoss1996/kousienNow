# frozen_string_literal: true

class CreateOneTimeCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :one_time_codes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :code, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
