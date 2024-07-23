class AddDate < ActiveRecord::Migration[7.1]
  def change
    add_column :user_matches, :date, :date
  end
end