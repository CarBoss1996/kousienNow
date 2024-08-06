class Event < ApplicationRecord
  has_many :event_dates
  def authorizable_ransackable_attributes(auth_object = nil)
    super & ['name', 'start_time']
  end
end
