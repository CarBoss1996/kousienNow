class RenameNameInLocations < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :name, :location_name
  end
end
