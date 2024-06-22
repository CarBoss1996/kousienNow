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
User.find_or_create_by!(email: 'test@example.com') do |user|
  user.user_name = 'aaa'
  user.last_name = 'aaa'
  user.first_name = 'aaa'
  user.password = 'password'
  user.password_confirmation = 'password'
end

Seat.seats.keys.each_with_index do |seat_name, index|
  Seat.find_or_create_by!(id: index + 1, seat: seat_name)
end
