class RenameLocationNameToSeatNameInLocations < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :location_name, :seat_name
  end
end
