# frozen_string_literal: true

# Model for publications which own articles e.g. New York Times
class Publication < ApplicationRecord
  has_many :articles
  validates_presence_of :name, :site
  validates_uniqueness_of :name, :site
  scope :new_york_times, -> { find_by(name: 'New York Times') }
  scope :long_reads, -> { find_by(name: 'Long Reads') }
  scope :nautilus, -> { find_by(name: 'Nautilus') }

  def self.top_publications
    Rails.cache.fetch('publications/top_publications', expires_in: 1.hour) do
      Publication.limit(15).pluck(:name)
    end
  end
end
