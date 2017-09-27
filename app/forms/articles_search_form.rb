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
    Publication.select(:name).limit(10).map(&:name).push('')
  end
end
