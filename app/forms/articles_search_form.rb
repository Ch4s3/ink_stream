# Simple class for bilding search forms
class ArticlesSearchForm < FormObject
  attr_accessor :title, :publications

  def initialize(title = '', publications = nil)
    @title = title
    @publications = publications ? publications : top_ten
  end

  private

  def top_ten
    Publication.select(:name).map(&:name).push('')
  end
end
