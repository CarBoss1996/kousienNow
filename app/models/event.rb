class Event < ApplicationRecord
  has_many :event_dates
  def self.ransackable_attributes(auth_object = nil)
    super - ['id'] + %w[start_date end_date]
  end
end
