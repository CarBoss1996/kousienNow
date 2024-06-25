class RenameTables < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_locations, :seat, index: true, foreign_key: true
    remove_column :locations, :latitude, :float
    remove_column :locations, :longitude, :float
    change_column :locations, :seat_name, :string
    add_column :seats, :min_latitude, :float
    add_column :seats, :max_latitude, :float
    add_column :seats, :min_longitude, :float
    add_column :seats, :max_longitude, :float
    remove_foreign_key :shapes, :seats
    drop_table :shapes
  end
end
