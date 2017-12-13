class Wanted < ApplicationRecord
  belongs_to :user
  has_many   :wanted_products
  has_many   :products, through: :wanted_products
# カートと同じように処理を定義
  # def wanted_informations(wanted)
  #   wanted.wanted_products
  # end

  # def wanted_price_sum(wanted)
  #   sum = 0
  #   wanted_informations(wanted).each do |wanted_info|
  #     sum  += wanted_info.product.price * wanted_info.product_count
  #   end
  #   return sum.floor.to_s(:delimited)
  # end

  # def wanted_count_sum(cart)
  #   sum = 0
  #   wanted_informations(wanted).each do |wanted_count|
  #     sum  += wanted_count.product_count
  #   end
  #   return sum.floor.to_s(:delimited)
  # end
end
