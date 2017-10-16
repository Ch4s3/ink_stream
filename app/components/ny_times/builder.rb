# frozen_string_literal: true

module NyTimes
  # A builder for articles that come from the New York Times
  class Builder
    attr_reader :article
    def initialize(response_body, article_path, article_id = nil)
      @article_path = article_path
      @response_body = response_body
      @xml = ::Nokogiri::HTML(@response_body)
      article_hash = build_article_hash
      @article = Article.upsert(article_hash, article_id)
    end

    # Builds a Hase with `Article` params
    #
    # @return [Hash] article params
    def build_article_hash
      {
        title: article_title,
        publication: Publication.new_york_times.first, # TODO: figure out why this can return > 1
        date: article_published_on,
        full_text: article_full_text,
        link: "https://www.nytimes.com#{@article_path}"
      }
    end

    private

    def article_title
      @xml.css('h1.headline').text.split('SHARE')[0]
    end

    def article_full_text
      @xml.css('.article-body').text
    end

    def article_published_on
      # TODO: fix this parsing
      DateTime.parse(@xml.css('.dateline').text)
    end
  end
end
