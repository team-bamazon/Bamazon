class Product < ApplicationRecord
  has_many   :carts,            through: :cart_products
  has_many   :wanteds,          through: :wanted_products
  has_many   :product_images
  has_many   :reviews
  belongs_to :product_category
end
