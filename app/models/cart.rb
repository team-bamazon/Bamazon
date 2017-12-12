class Cart < ApplicationRecord
  belongs_to :user
  has_many   :cart_products
  has_many   :products, through: :cart_products

  def cart_informations(cart)
    cart.cart_products
  end

  def cart_price_sum(cart)
    sum = 0
    cart_informations(cart).each do |cart_info|
      sum  += cart_info.product.price * cart_info.product_count
    end
    return sum.floor.to_s(:delimited)
  end

  def cart_count_sum(cart)
    sum = 0
    cart_informations(cart).each do |cart_count|
      sum  += cart_count.product_count
    end
    return sum.floor.to_s(:delimited)
  end
end
