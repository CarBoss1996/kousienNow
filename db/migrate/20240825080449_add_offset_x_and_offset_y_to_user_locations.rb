class AddOffsetXAndOffsetYToUserLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :user_locations, :offset_x, :integer
    add_column :user_locations, :offset_y, :integer
  end
end
