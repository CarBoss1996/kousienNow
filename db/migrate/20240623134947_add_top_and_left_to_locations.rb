class AddTopAndLeftToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :top, :float
    add_column :locations, :left, :float
  end
end
