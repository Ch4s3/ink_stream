# frozen_string_literal: true

module Nautilus
  # A builder for articles that come from Nautilus
  class Builder < GenericBuilder
    private

    def publication
      Publication.nautilus.first
    end

    def publication_url
      'http://http://mitp.nautil.us/'
    end

    def article_title
      @xml.css('.LongformA_textbody h2').text
    end

    def article_full_text
      @xml.css('article').text
    end

    def article_published_on
      # Inexact since Nautilus uses monthly publication
      DateTime.parse(@xml.css('.general_datetype').text)
    end
  end
end
