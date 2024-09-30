# frozen_string_literal: true

class AddDetailUrlToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :detail_url, :string
  end
end
