class Event < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    super - ['id'] + %w[start_date end_date]
  end
end
