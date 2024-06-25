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

area_data = [
  { id: 1, location_type: :backnet, points: "42.39,70.86,24.69,82.62,34.14,90.91,66.01,91.57,76.50,83.02,59.00,71.12,55.88,74.20,47.78,74.20,47.78,74.20" },
  { id: 2, location_type: 'smbc_seat', points: "71.13,52.28,59.00,70.18,64.38,74.20,74.90,54.55" },
  { id: 3, location_type: 'ivy_seat', points: "70.85,52.94,60.19,70.05,76.64,82.35,88.52,59.76" },
  { id: 4, location_type: 'breeze_seat', points: "25.10,53.61,11.20,59.23,24.50,83.16,36.71,74.73" },
  { id: 5, location_type: 'first_base_alps', points: "79.76,32.48,70.98,50.53,89.74,59.36,98.11,35.29" },
  { id: 6, location_type: 'third_base_alps', points: "20.51,32.22,3.37,35.69,11.87,58.43,27.80,50.93" },
  { id: 7, location_type: 'right_outfield', points: "57.10,4.01,82.84,12.83,95.29,33.29,81.08,31.22,71.40,20.99,54.67,17.91" },
  { id: 8, location_type: 'left_outfield', points: "42.77,4.68,19.57,12.17,5.94,33.02,20.78,31.02,28.34,21.39,45.07,17.38" },
  { id: 9, location_type: 'home_cheering', points: "2.97,48.13,3.77,93.31,27.49,93.31" }
]

area_data.each do |data|
  points_array = data[:points].split(',').each_slice(2).map { |x, y| { x: x.to_f, y: y.to_f } }
  location = Location.find_or_create_by!(id: data[:id], location_type: data[:location_type]) do |location|
    location.points = points_array.to_json
  end
end