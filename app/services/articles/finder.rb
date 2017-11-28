module Articles
  # Simple service object for finging articles
  class Finder
    attr_reader :last_fetched
    # Finds articles based on publication name and article title or partial title
    #
    # @param [ArticlesSearchForm] search
    # @return [Article::ActiveRecord_Relation, Array] the resulting Articles or
    # an empty array
    def self.find(search)
      title = search.title
      publication = search.selected_publication
      offset = search.search_offset
      cache_key = "articles/#{title}/offset=#{offset}&publication=#{publication}"
      Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
        if publication.strip.empty?
          Article.fuzzy_title(title).ten_ids_with_offset(offset)
        else
          Article.by_title_pub_and_offset(title, publication, offset)
        end
      end
    end
  end
end
