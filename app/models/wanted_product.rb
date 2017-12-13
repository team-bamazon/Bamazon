class WantedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :wanted
# cart_productsと同じような処理を記述
#   def product_price_sum(wanted_product)
#     cart_products = WantedProduct.where(wanted_id: wanted_product.wanted_id)
#     sum = 0
#     wanted_products.each do |wanted_item|
#       price_sum =  wanted_item.product.price * wanted_item.product_count
#       sum += price_sum
#     end
#     return sum.floor.to_s(:delimited)
#   end

#   def product_count_sum(wanted_product)
#     wanted_products = WantedProduct.where(wanted_id: wanted_product.wanted_id)
#     sum = 0
#     wanted_products.each do |wanted_item|
#       sum += wanted_item.product_count.to_i
#     end
#     return sum.floor.to_s(:delimited)
#   end

#   def bamazon_point(wanted_product)
#     wanted_products = WantedProduct.where(wanted_id: wanted_product.wanted_id)
#     sum = 0
#     wanted_products.each do |wanted_item|
#       price_sum =  wanted_item.product.price * wanted_item.product_count
#       sum += price_sum
#     end
#     return sum.floor
#   end
end
