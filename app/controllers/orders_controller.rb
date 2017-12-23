class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def edit
    @order = Order.find(params[:id])
    @address = Address.new
    @card = PaymentInformation.new

    # @new_order = Order.new
  end

  def update
    @order = Order.find(params[:id])
    # @order.update(order_params)
    # redirect_to order_path
  end

  private
  def order_params
    params.require(:order).permit(:full_name, :postal_code_one, :postal_code_two, :region, :street_address_one, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
