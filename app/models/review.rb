class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many   :review_comments
end
