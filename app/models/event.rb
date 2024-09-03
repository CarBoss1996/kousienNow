class Event < ApplicationRecord
  has_many :event_dates
  def authorizable_ransackable_attributes(auth_object = nil)
    super & ['name', 'start_time']
  end

  def self.ransackable_associations(auth_object = nil)
    %w(event_dates)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(body created_at detail_url id id_value title updated_at)
  end
end
