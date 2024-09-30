# frozen_string_literal: true

class ChangeDateToStartDateAndEndDateInEventDates < ActiveRecord::Migration[7.1]
  def change
    remove_column :event_dates, :date, :datetime
    add_column :event_dates, :start_date, :date
    add_column :event_dates, :end_date, :date
  end
end
