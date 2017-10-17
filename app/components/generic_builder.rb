# frozen_string_literal: true

# A generic builder for articles
class GenericBuilder
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
      publication: publication,
      date: article_published_on,
      full_text: article_full_text,
      link: "#{publication_url}#{@article_path}"
    }
  end

  private

  def publication_url
    raise NotImplementedError, 'You must implement the publication_url method'
  end

  def article_title
    raise NotImplementedError, 'You must implement the article_title method'
  end

  def article_full_text
    raise NotImplementedError, 'You must implement the article_full_text method'
  end

  def article_published_on
    raise NotImplementedError, 'You must implement the article_published_on method'
  end
end
