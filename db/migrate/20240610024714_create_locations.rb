class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.references :user, foreign_key: true
      t.string :icon
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
