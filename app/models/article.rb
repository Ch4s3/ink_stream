class Article < ApplicationRecord
  belongs_to :publication, optional: true
  scope :fuzzy_title, ->(title) { where('title LIKE ?', "%#{title}%") }
end
