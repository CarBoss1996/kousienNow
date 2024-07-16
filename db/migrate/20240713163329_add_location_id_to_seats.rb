class AddLocationIdToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :location_id, :bigint
    add_index :seats, :location_id
  end
end
