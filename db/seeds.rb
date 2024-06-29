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
  # UserLocationの作成
  user.user_locations.find_or_create_by!(location_id: Date.today.to_s) do |user_location|
    user_location.icon = 'beer.png'
    user_location.location_id = 5
  end

  # Postの作成
  user.posts.find_or_create_by!(content: 'テストテスト') do |post|
    post.created_at = Date.today
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
