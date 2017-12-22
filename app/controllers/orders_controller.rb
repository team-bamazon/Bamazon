class OrdersController < ApplicationController

  def create
    # @order = Order.find(params[:id])
    Address.create(full_name:          @order.full_name,
                   postal_code_one:    @order.postal_code_one,
                   postal_code_two:    @order.postal_code_two,
                   region:             @order.region,
                   street_address_one: @order.street_address_one,
                   building_name:      @order.building_name,
                   phone_number:       @order.phone_number)
    binding.pry
    redirect_to order_path
  end

  def show
    @order = Order.find(params[:id])
    @new_order = Order.new
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_path
  end

  private

  def order_params
    params.require(:order).permit(:full_name, :postal_code_one, :postal_code_two, :region, :street_address_one, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
