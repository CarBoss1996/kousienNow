# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
User.find_or_create_by!(email: 'aaa@aaa') do |user|
  user.user_name = 'aaa'
  user.last_name = 'aaa'
  user.first_name = 'aaa'
  user.password = 'aaaaaa'
  user.password_confirmation = 'aaaaaa'
end

Seat.seats.keys.each_with_index do |seat_name, index|
  Seat.find_or_create_by!(id: index + 1, seat: seat_name, seat_name: seat_name)
end

area_data = [
  { seat_id: 1, points: "42.39,70.86,24.69,82.62,34.14,90.91,66.01,91.57,76.50,83.02,59.00,71.12,55.88,74.20,47.78,74.20,47.78,74.20" },
  { seat_id: 2, points: "71.13,52.28,59.00,70.18,64.38,74.20,74.90,54.55" },
  { seat_id: 2, points: "30.23,52.81,25.50,54.14,36.84,75.13,41.97,71.65" },
  { seat_id: 3, points: "70.85,52.94,60.19,70.05,76.64,82.35,88.52,59.76" },
  { seat_id: 4, points: "25.10,53.61,11.20,59.23,24.50,83.16,36.71,74.73" },
  { seat_id: 5, points: "79.76,32.48,70.98,50.53,89.74,59.36,98.11,35.29" },
  { seat_id: 6, points: "20.51,32.22,3.37,35.69,11.87,58.43,27.80,50.93" },
  { seat_id: 7, points: "57.10,4.01,82.84,12.83,95.29,33.29,81.08,31.22,71.40,20.99,54.67,17.91" },
  { seat_id: 8, points: "42.77,4.68,19.57,12.17,5.94,33.02,20.78,31.02,28.34,21.39,45.07,17.38" },
  { seat_id: 9, points: "2.97,48.13,3.77,93.31,27.49,93.31" },
  { seat_id: 9, points: "97.43,45.45,73.31,91.71,98.24,92.11" }
]

area_data.each do |data|
  points_array = data[:points].split(',').each_slice(2).map { |x, y| { x: x.to_f, y: y.to_f } }
  puts "points: #{data[:points]}"
  puts "points_array: #{points_array}"
  puts "Location columns: #{Location.column_names}"
  location = Location.new(seat_id: data[:seat_id], points: points_array.to_json)
  unless location.save(validate: false)
    puts "Failed to save location: #{location.errors.full_messages.join(", ")}"
  end
end