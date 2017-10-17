# frozen_string_literal: true

module LongReads
  # A builder for articles that come from Long Reads
  class Builder < GenericBuilder
    private

    def publication
      Publication.long_reads.first
    end

    def publication_url
      'https://www.longreads.com'
    end

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
