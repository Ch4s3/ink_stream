# frozen_string_literal: true

# Simple class for bilding search forms
class ArticlesSearchForm < FormObject
  attr_accessor :title, :publications, :search_offset

  def initialize(title = '', publications = nil, search_offset = 0)
    @title = title
    @publications = publications ? publications : top_ten
    @search_offset = search_offset
  end

  private

  def top_ten
    Rails.cache.fetch('publications/top_ten', expires_in: 1.hour) do
      Publication.limit(10).pluck(:name).push('')
    end
  end
end
