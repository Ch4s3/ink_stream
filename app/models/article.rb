# AcriveRecord model for articles, core to the app
class Article < ApplicationRecord
  belongs_to :publication, optional: true
  scope :fuzzy_title, ->(title) { where('title LIKE ?', "%#{title}%") }

  # Updates an existing article with new data from a hash,
  # given an existing id
  #
  # @param article_hash [Hash]
  # @param article_id [Integer]
  # @return [Article|nil]
  def self.update_with_hash_by_id(article_hash, article_id)
    article = Article.find_by(id: article_id)
    article.update(article_hash) if article
  end
end
