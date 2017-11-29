class Wanted < ApplicationRecord
  belongs_to :user
  has_many   :products, throught: :wanted_products
end
