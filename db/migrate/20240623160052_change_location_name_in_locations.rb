class ChangeLocationNameInLocations < ActiveRecord::Migration[6.0]
  def up
    change_column :locations, :location_name, 'integer USING CAST(location_name AS integer)'
  end

  def down
    change_column :locations, :location_name, :string
  end
end