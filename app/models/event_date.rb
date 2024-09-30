# frozen_string_literal: true

class EventDate < ApplicationRecord
  belongs_to :event
  def self.ransackable_attributes(_auth_object = nil)
    %w[start_date end_date]
  end
end
