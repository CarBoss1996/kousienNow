class CreateUserLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_locations do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
