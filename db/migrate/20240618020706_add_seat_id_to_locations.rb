class AddSeatIdToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :seat, null: false, foreign_key: true
  end
end
