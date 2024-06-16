class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :body
      t.datetime :event_date

      t.timestamps
    end
  end
end
