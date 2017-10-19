# frozen_string_literal: true

# Simple class for bilding search forms
class ArticlesSearchForm < FormObject
  attr_accessor :title, :publications, :search_offset

  # setting up a blank form
  #
  # @param [String] title initializes with a blank string
  # @param [ActiveRecord::Relation | Nil] publications initializes with nil
  # @param [Integer] search_offset initializes with 0
  # @return [ArticlesSearchForm]
  def initialize(title = '', publications = nil, search_offset = 0)
    @title = title
    @publications = publications ? publications : top_ten
    @search_offset = search_offset
  end

  private

  def top_ten
    Rails.cache.fetch('publications/top_ten', expires_in: 1.hour) do
      Publication.limit(15).pluck(:name).push('')
    end
  end
end
