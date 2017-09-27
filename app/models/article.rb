class Article < ApplicationRecord
  belongs_to :publication
  scope :fuzzy_title, ->(title) { where('title LIKE ?', "%#{title}%") }
end
