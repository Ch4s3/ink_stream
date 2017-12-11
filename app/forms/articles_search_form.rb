# frozen_string_literal: true

# Simple class for bilding search forms
class ArticlesSearchForm < FormObject
  attr_reader :title, :publications, :search_offset
  validates_presence_of :title
  # setting up a blank form
  #
  # @param [String] title initializes with a blank string
  # @param [ActiveRecord::Relation] publications
  # @param [Integer] search_offset initializes with 0
  # @return [ArticlesSearchForm]
  def initialize(title = '', publications = Publication.top_publications, search_offset = 0)
    @title = title
    @publications = publications
    @search_offset = search_offset
  end

  def selected_publication
    @publications.first
  end
end
