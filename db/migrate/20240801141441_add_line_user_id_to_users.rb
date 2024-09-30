# frozen_string_literal: true

class AddLineUserIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :line_user_id, :string
  end
end
