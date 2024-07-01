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
user = User.find_or_create_by!(email: 'aaa@aaa') do |user|
  user.user_name = 'aaa'
  user.last_name = 'aaa'
  user.first_name = 'aaa'
  user.password = 'aaaaaa'
  user.password_confirmation = 'aaaaaa'
end

locations = [
    { id: 1, location_type: :backnet, seat_name: "backnet", points: [{ x: 36, y: 72 }, { x: 25, y: 81 }, { x: 32, y: 86 }, { x: 58, y: 86 }, { x: 67, y: 81 }, { x: 55, y: 72 }] },
    { id: 2, location_type: :smbc_seat, seat_name: "smbc_seat", points: [{ x: 59, y: 68 }, { x: 67, y: 53 }, { x: 64, y: 61 }] },
    { id: 3, location_type: :ivy_seat, seat_name: "ivy_seat", points: [{ x: 73, y: 54 }, { x: 81, y: 58 }, { x: 64, y: 71 }, { x: 72, y: 76 }] },
    { id: 4, location_type: :breeze_seat, seat_name: "breeze_seat", points:  [{ x: 25, y: 52 }, { x: 11, y: 58 }, { x: 21, y: 76 }, { x: 33, y: 67 }] },
    { id: 5, location_type: :first_base_alps, seat_name: "first_base_alps", points: [{ x: 76, y: 32 }, { x: 71, y: 45 }, { x: 84, y: 51 }, { x: 90, y: 34 }] },
    { id: 6, location_type: :third_base_alps, seat_name: "third_base_alps", points: [{ x: 2, y: 34 }, { x: 8, y: 52 }, { x: 21, y: 46 }, { x: 15, y: 31 }] },
    { id: 7, location_type: :right_outfield, seat_name: "right_outfield", points: [{ x: 55, y: 2 }, { x: 54, y: 11 }, { x: 69, y: 15 }, { x: 77, y: 24 }, { x: 89, y: 26 }, { x: 78, y: 8 }] },
    { id: 8, location_type: :left_outfield, seat_name: "left_outfield", points: [{ x: 38, y: 2 }, { x: 38, y: 11 }, { x: 23, y: 16 }, { x: 15, y: 24 }, { x: 4, y: 26 }, { x: 12, y: 10 }] },
    { id: 9, location_type: :home_cheering, seat_name: "home_cheering", points: [{ x: 30, y: 26 }, { x: 30, y: 37 }, { x: 60, y: 37 }, { x: 60, y: 26 }] }
  ]

  locations.each do |location|
    Location.create(location_type: location[:location_type], seat_name: location[:seat_name], points: location[:points].to_json)
  end

matches = [
  { match_date: '2024-07-01 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-02 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-03 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-04 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-05 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-07-06 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-07-07 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-07-09 18:00', opponent: Match.opponents[:ヤクルト] },
  { match_date: '2024-07-10 18:00', opponent: Match.opponents[:ヤクルト] },
  { match_date: '2024-07-12 18:00', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-13 14:00', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-14 13:30', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-15 14:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-07-16 18:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-07-17 18:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-07-19 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-20 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-21 18:00', opponent: Match.opponents[:広島] },
  { match_date: '2024-07-26 18:00', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-27 18:00', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-28 18:00', opponent: Match.opponents[:中日] },
  { match_date: '2024-07-30 18:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-07-31 18:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-08-01 18:00', opponent: Match.opponents[:巨人] },
  { match_date: '2024-08-02 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-08-03 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-08-04 18:00', opponent: Match.opponents[:DeNA] },
  { match_date: '2024-08-06 18:00', opponent: Match.opponents[:ヤクルト] },
  { match_date: '2024-08-07 18:00', opponent: Match.opponents[:ヤクルト] },
  { match_date: '2024-08-08 18:00', opponent: Match.opponents[:ヤクルト], stadium: :jingu },
]

matches.each do |match|
  Match.create!(match)
end