# frozen_string_literal: true

# Model for publications which own articles e.g. New York Times
class Publication < ApplicationRecord
  has_many :articles
  scope :new_york_times, -> { find_by(name: 'New York Times') }
end
