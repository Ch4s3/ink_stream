module Articles
  # Simple service object for finging articles
  class Finder
    attr_reader :last_fetched
    # Finds articles based on publication name and article title or partial title
    #
    # @param publication_name [String] the publications name or a blank string
    # @param article_title [String] the article title
    # @return [Article::ActiveRecord_Relation, Array] the resulting Articles or
    # an empty array
    def self.find(publication_name, article_title)
      @articles ||=
        Article.joins(:publication).where('title LIKE ?', "%#{article_title}%")
               .where('publications.name = ?', publication_name)
               .select(:title, :id)

      @articles
    end
  end
end
