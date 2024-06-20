class ChangeSetaId < ActiveRecord::Migration[6.0]
  def up
    # remove the old foreign_key
    remove_foreign_key :locations, column: :seat_id

    # change the type of seat_id from string to integer
    change_column :locations, :seat_id, 'integer USING CAST(seat_id AS integer)'

    # add the new foreign_key
    add_foreign_key :locations, :seats
  end

  def down
    # rollback changes if needed
    add_foreign_key :locations, :seats, primary_key: :seat_name
    change_column :locations, :seat_id, :string
  end
end