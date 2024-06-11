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
Seat.create!(
  name: 'バックネット',
  shapes_attributes: [
    {
      min_latitude: 34 + 43/60.0 + 18.750/3600.0,
      max_latitude: 34 + 43/60.0 + 20.405/3600.0,
      min_longitude: 135 + 21/60.0 + 40.565/3600.0,
      max_longitude: 135 + 21/60.0 + 42.523/3600.0
    },  #ど真ん中
    {
      min_latitude: 34 + 43/60.0 + 19.693/3600.0,
      max_latitude: 34 + 43/60.0 + 20.405/3600.0,
      min_longitude: 135 + 21/60.0 + 39.599/3600.0,
      max_longitude: 135 + 21/60.0 + 40.565/3600.0
    }, #左上
    {
      min_latitude: 34 + 43/60.0 + 18.750/3600.0,
      max_latitude: 34 + 43/60.0 + 19.693/3600.0,
      min_longitude: 135 + 21/60.0 + 40.417/3600.0,
      max_longitude: 135 + 21/60.0 + 40.565/3600.0
    }, #左下
    {
      min_latitude: 34 + 43/60.0 + 19.706/3600.0,
      max_latitude: 34 + 43/60.0 + 20.405/3600.0,
      min_longitude: 135 + 21/60.0 + 40.565/3600.0,
      max_longitude: 135 + 21/60.0 + 44.079/3600.0
    }, #右上
    {
      min_latitude: 34 + 43/60.0 + 18.750/3600.0,
      max_latitude: 34 + 43/60.0 + 19.706/3600.0,
      min_longitude: 135 + 21/60.0 + 40.565/3600.0,
      max_longitude: 135 + 21/60.0 + 43.214/3600.0
    }, #右下
    {
      min_latitude: 34 + 43/60.0 + 19.125/3600.0,
      max_latitude: 34 + 43/60.0 + 19.706/3600.0,
      min_longitude: 135 + 21/60.0 + 40.565/3600.0,
      max_longitude: 135 + 21/60.0 + 43.698/3600.0
    } #右下右
  ]
)