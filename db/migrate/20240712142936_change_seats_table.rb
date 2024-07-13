class ChangeSeatsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :seats, :min_latitude
    remove_column :seats, :max_latitude
    remove_column :seats, :min_longitude
    remove_column :seats, :max_longitude
    add_column :seats, :spots, :jsonb, default: []
  end
end
