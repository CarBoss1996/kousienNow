class EventIdNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :matches, :event_id, true
  end
end
