class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def product_price_sum(cart_product)
    cart_products = CartProduct.where(cart_id: cart_product.cart_id)
    sum = 0
    cart_products.each do |cart_item|
      price_sum =  cart_item.product.price * cart_item.product_count
      sum += price_sum
    end
    return sum.floor.to_s(:delimited)
  end

  def product_count_sum(cart_product)
    cart_products = CartProduct.where(cart_id: cart_product.cart_id)
    sum = 0
    cart_products.each do |cart_item|
      sum += cart_item.product_count.to_i
    end
    return sum.floor.to_s(:delimited)
  end

  def bamazon_point(cart_product)
    cart_products = CartProduct.where(cart_id: cart_product.cart_id)
    sum = 0
    cart_products.each do |cart_item|
      price_sum =  cart_item.product.price * cart_item.product_count
      sum += price_sum
    end
    return sum.floor
  end

end
