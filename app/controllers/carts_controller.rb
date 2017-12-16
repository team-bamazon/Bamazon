class CartsController < ApplicationController
  def edit
    @order_product = OrderProduct.new
  end
end
