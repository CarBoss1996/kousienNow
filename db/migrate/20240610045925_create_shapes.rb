class CreateShapes < ActiveRecord::Migration[7.1]
  def change
    create_table :shapes do |t|
      t.references :seat, null: false, foreign_key: true
      t.float :min_latitude
      t.float :max_latitude
      t.float :min_longitude
      t.float :max_longitude

      t.timestamps
    end
  end
end
