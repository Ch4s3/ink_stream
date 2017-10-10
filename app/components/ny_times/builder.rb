module NyTimes
  # A builder for articles that come from the New York Times
  class Builder
    attr_reader :article
    def initialize(response_body, article_path, article_id = nil)
      @article_path = article_path
      @response_body = response_body
      parse_response
      article_hash = build_article_hash
      @article =
        if article_id
          update_article(article_hash, article_id)
        else
          create_article(article_hash)
        end
    end

    # Builds a Hase with `Article` params
    #
    # @return [Hash] article params
    def build_article_hash
      {
        title: article_title,
        publication: new_york_times,
        date: article_published_on,
        excerpt: article_excerpt(article_body),
        link: "https://www.nytimes.com#{@article_path}"
      }
    end

    private

    def update_article(article_hash, article_id)
      article = Article.find_by(id: article_id)
      article.update(article_hash)
    end

    def create_article(article_hash)
      Article.create(article_hash)
    end

    def parse_response
      @xml = ::Nokogiri::HTML(@response_body)
    end

    def new_york_times
      Publication.find_by(name: 'New York Times')
    end

    def article_title
      @xml.css('h1.headline').text.split('SHARE')[0]
    end

    def article_body
      @xml.css('.article-body').text
    end

    def article_excerpt(article_body)
      article_body.split(' ')[0..15].join(' ')
    end

    def article_published_on
      # TODO: fix this parsing
      DateTime.parse(@xml.css('.dateline').text)
    end
  end
end
