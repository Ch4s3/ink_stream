module NyTimes
  # A builder for articles that come from the New York Times
  class Builder
    attr_reader :article
    @base_url = 'https://www.nytimes.com'
    def initialize(response_body, article_path)
      @article_path = article_path
      @response_body = response_body
      parse_response
      @article = build_article
    end

    # Builds an `Article` model using `find_or_create_by``
    #
    # @return [Article]
    def build_article
      Article.create_with(
        title: article_title,
        publication: new_york_times,
        date: article_published_on,
        excerpt: article_excerpt(article_body)
      ).find_or_create_by(link: "@base_url#{@article_path}")
    end

    private

    def parse_response
      @xml = ::Nokogiri::XML(@response_body)
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
