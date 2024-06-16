class RenameSeats < ActiveRecord::Migration[7.1]
  def change
    rename_column :seats, :name, :seat_name
  end
end
