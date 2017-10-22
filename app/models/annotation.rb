class Annotation < ApplicationRecord
  belongs_to :article, touch: true
  belongs_to :user
end
