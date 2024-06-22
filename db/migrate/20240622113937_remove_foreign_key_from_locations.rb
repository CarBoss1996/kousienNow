class RemoveForeignKeyFromLocations < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :locations, :seats
  end
end
