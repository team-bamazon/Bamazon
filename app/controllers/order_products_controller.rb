class OrderProductsController < ApplicationController
  before_action :set_order, only: [:create]

  def create
    cart_products = current_user.cart.cart_products

    cart_products.each do |cart_product|
      product = cart_product.product
      product_image = product.product_images.present? ? product.product_images.first.image : "https://images-fe.ssl-images-amazon.com/images/G/09/icons/books/comingsoon_books._V376986337_BO1,204,203,200_.gif"
      OrderProduct.create(order_id:      @order.id,
                          product_name:  product.name,
                          price:         product.price,
                          product_image: product_image,
                          count:         cart_product.product_count,
                          product_id:    product.id)
    end

    redirect_to order_path(@order)
  end

  private

  def set_order
    if current_user.orders.present?
      @order = Order.find_by(user_id: current_user.id, status: 0)
      @order.destroy
    end
    @order = Order.create(user_id: current_user.id, status: 0)
  end
end
