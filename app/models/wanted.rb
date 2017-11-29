class Wanted < ApplicationRecord
  belongs_to :user
  has_many   :products, through: :wanted_products
end
