class AddIndexesToEventDates < ActiveRecord::Migration[7.1]
  def change
    add_index :event_dates, :start_date
    add_index :event_dates, :end_date
  end
end
