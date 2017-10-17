# frozen_string_literal: true

module NyTimes
  # A builder for articles that come from the New York Times
  class Builder < GenericBuilder
    private

    def publication
      Publication.new_york_times.first
    end

    def publication_url
      'https://www.nytimes.com'
    end

    def article_title
      @xml.css('h1.headline').text.split('SHARE')[0]
    end

    def article_full_text
      @xml.css('.story-body.story-body-2').text
    end

    def article_published_on
      # TODO: fix this parsing
      DateTime.parse(@xml.css('.dateline').text)
    end
  end
end
