# frozen_string_literal: true

module LongReads
  # A builder for articles that come from Long Reads
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
        publication: Publication.long_reads.first,
        date: article_published_on,
        full_text: article_full_text,
        link: "https://www.nytimes.com#{@article_path}"
      }
    end

    private

    def article_title
      @xml.css('h1.entry-title').children[1].text
    end

    def article_full_text
      @xml.css('.entry-content').text
    end

    def article_published_on
      date = @xml.css('.author-date')[0].children[6].text
      DateTime.parse(date)
    end
  end
end
