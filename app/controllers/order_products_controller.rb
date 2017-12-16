class OrderProductsController < ApplicationController
  before_action :set_order, only: [:create]

  def create
    times_number.times do |i|
    @order_product = OrderProduct.new(set_order_product(i))
    @order_product.save
    end
    redirect_to order_path(@order)
  end

  private

  def set_order_product(i)
      ActionController::Parameters.new(params[:order_product].require(:order_info).values[i]).permit(:product_name, :price, :product_image, :count).merge(order_id: @order.id)
  end

  def times_number
    n = params[:order_product][:order_info].values.length
    return n
  end

  def set_order
    if current_user.orders.present?
      @order = Order.find(current_user.order.id)
    else
      @order = Order.create(user_id: current_user.id)
    end
  end

end
