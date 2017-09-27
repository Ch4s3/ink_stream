module Articles
  # Simple service object for finging articles
  class Finder
    attr_reader :last_fetched
    # Finds articles based on publication name and article title or partial title
    #
    # @param publication_name [String] the publications name or a blank string
    # @param article_title [String] the article title
    # @param offset [Number] the number of articles to offset by
    # @return [Article::ActiveRecord_Relation, Array] the resulting Articles or
    # an empty array
    def self.find(publication_name, article_title, offset = 0)
      cache_key = "articles/#{publication_name}/#{article_title}/offset=#{offset}"
      Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
        if publication_name.strip.empty?
          Article.fuzzy_title(article_title)
                 .select(:title, :id, :uuid).order('id desc')
                 .limit(10).offset(offset)
        else
          Article.joins(:publication).fuzzy_title(article_title)
                 .where('publications.name = ?', publication_name)
                 .select(:title, :id, :uuid).order('id desc')
                 .limit(10).offset(offset)
        end
      end
    end
  end
end
