class AddUniqueIndexToSeats < ActiveRecord::Migration[7.1]
  def change
    add_index :seats, :seat_name, unique: true
  end
end
