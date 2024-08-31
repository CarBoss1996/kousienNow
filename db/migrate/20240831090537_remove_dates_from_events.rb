class RemoveDatesFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :event_date, :datetime
    remove_column :events, :start_date, :date
    remove_column :events, :end_date, :date
  end
end
