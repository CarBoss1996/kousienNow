class ModifyTables < ActiveRecord::Migration[7.1]
  def change
    add_column :user_locations, :icon, :integer
    add_reference :users, :seat, foreign_key: true
    remove_column :locations, :icon, :integer
    remove_column :locations, :top, :float
    remove_column :locations, :left, :float
    remove_column :locations, :top_start, :float
    remove_column :locations, :top_end, :float
    remove_column :locations, :left_start, :float
    remove_column :locations, :left_end, :float
  end
end
