class AddInitialSeats < ActiveRecord::Migration[6.0]
  def up
    Seat.seats.keys.each_with_index do |seat_name, index|
      Seat.find_or_create_by!(id: index + 1, seat: seat_name)
    end
  end

  def down
    # 逆の操作を記述します。ここでは何もしないことにします。
  end
end