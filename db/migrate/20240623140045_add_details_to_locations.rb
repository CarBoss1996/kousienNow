class AddDetailsToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :top_start, :float
    add_column :locations, :top_end, :float
    add_column :locations, :left_start, :float
    add_column :locations, :left_end, :float
  end
end
