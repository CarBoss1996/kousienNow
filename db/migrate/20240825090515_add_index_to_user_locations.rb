class AddIndexToUserLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :user_locations, :index, :integer
  end
end
