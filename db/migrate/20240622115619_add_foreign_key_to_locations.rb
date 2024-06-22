class AddForeignKeyToLocations < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :locations, :seats, column: :seat_id, primary_key: "id"
  end
end
