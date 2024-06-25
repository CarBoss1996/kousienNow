class AddPointsToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :points, :jsonb
  end
end
