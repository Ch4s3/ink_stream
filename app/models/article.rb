# frozen_string_literal: true

# AcriveRecord model for articles, core to the app
class Article < ApplicationRecord
  belongs_to :publication, optional: true
  has_many :annotations
  scope :fuzzy_title, ->(title) { where('title LIKE ?', "%#{title}%") }

  # Upserts an article with new data from a hash,
  # creating it if the id desn not exist or updating
  # the article if the id exists
  #
  # @param [Hash] article_hash
  # @param [Integer|nil] article_id
  # @return [Boolean|nil]
  def self.upsert(article_hash, article_id)
    if article_id
      update_with_hash_by_id(article_hash, article_id)
    else
      create(article_hash)
    end
  end

  def self.by_title_pub_and_offset(title, publication, offset)
    joins(:publication)
      .fuzzy_title(title)
      .where('publications.name = ?', publication)
      .ten_ids_with_offset(offset)
  end

  # Updates an existing article with new data from a hash,
  # given an existing id
  #
  # @param [Hash] article_hash
  # @param [Integer] article_id
  # @return [Boolean|nil]
  def self.update_with_hash_by_id(article_hash, article_id)
    article = Article.find_by(id: article_id)
    article.update(article_hash) if article
  end

  # Selects 10 rows of`:title`, `:id`, & `:uuid` from a collection of
  # articles and offsets them by a given ammount, defaulting to 0
  #
  # @param [Integer] offset
  # @return [Article::ActiveRecord_Relation]
  def self.ten_ids_with_offset(offset = 0)
    select(:title, :id, :uuid).order('id desc').limit(10).offset(offset)
  end
end
