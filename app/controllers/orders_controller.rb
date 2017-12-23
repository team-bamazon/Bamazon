class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def edit
    @order = Order.find(params[:id])
    @address = Address.new
    @card = PaymentInformation.new
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: 1,
                  country: current_user.addresses.last.country,
                  full_name: current_user.addresses.last.full_name,
                  postal_code_one: current_user.addresses.last.postal_code_one,
                  postal_code_two: current_user.addresses.last.postal_code_two,
                  region: current_user.addresses.last.region,
                  street_address_one: current_user.addresses.last.street_address_one,
                  street_address_two: current_user.addresses.last.street_address_two,
                  building_name: current_user.addresses.last.building_name,
                  phone_number: current_user.addresses.last.phone_number,
                  card_name: current_user.payment_informations.last.card_name,
                  card_number: current_user.payment_informations.last.card_number,
                  month: current_user.payment_informations.last.month,
                  year: current_user.payment_informations.last.year)
    @cart.destroy
  end

end
