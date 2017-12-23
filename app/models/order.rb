class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_products, dependent: :destroy
  has_many   :addresses
  has_many   :payment_information

  def number_method
    return card_number[card_number.length-4, 4]
  end

  def order_price_sum(order)
    sum = 0
    order.order_products.each do |order_product|
      sum += order_product.price.to_i
    end
    return sum
  end

  def order_number(order)
    products_number = ""
    order_products_number = ""
    order.order_products.each do |order_product|
      products_number += order_product.product_id.to_s
      order_products_number += order_product.id.to_s
    end
    number = order.id.to_s + "-" + order_products_number + "-" + products_number

    return number
  end

  def order_total_price_sum(order)
    sum = 0
    order.order_products.each do |order_product|
      sum += order_product.price.to_i
    end
    return sum + 360
  end
end
