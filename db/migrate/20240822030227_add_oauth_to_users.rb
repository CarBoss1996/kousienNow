# frozen_string_literal: true

class AddOauthToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
end
