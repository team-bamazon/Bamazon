class OrderProductsController < ApplicationController
  def create
    times_number.times do |i|
    @order_product = OrderProduct.new(set_order_product(i))
    # @order_product.save
    end
  end

  private

  def set_order_product(i)
      ActionController::Parameters.new(params[:order_product].require(:order_info).values[i]).permit(:product_name, :price, :product_image, :count)
  end

  def times_number
    n = params[:order_product][:order_info].values.length
    return n
  end

end
