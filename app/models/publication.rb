class Publication < ApplicationRecord
  has_many :articles
  scope :new_york_times, -> { find_by(name: 'New York Times') }
end
