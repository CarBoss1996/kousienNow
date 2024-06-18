class AddSeatToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :seat, :integer, default: 0, null: false
  end
end
