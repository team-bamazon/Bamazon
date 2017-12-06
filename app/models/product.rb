class Product < ApplicationRecord
  has_many   :cart_products
  has_many   :carts,            through: :cart_products
  has_many   :wanted_products
  has_many   :wanteds,          through: :wanted_products
  has_many   :product_images
  has_many   :reviews
  belongs_to :product_category

  accepts_nested_attributes_for :product_images
end
