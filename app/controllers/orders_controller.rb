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

  def new_select_address
    @order = Order.find(params[:id])
    @address = Address.new
    @user_addresses = current_user.addresses

  end

  def order_new_address_create
    @order = Order.find(params[:id])
    @change_address = Address.find_by(status: 1, user_id: current_user.id)
    @change_address.update(status: 0) if @change_address.present?
    @address = Address.new(order_new_address_params)
    @address.save
    redirect_to edit_order_path
  end

  private

  def order_new_address_params
    params.require(:address).permit(:full_name, :country, :postal_code_one, :postal_code_two, :region, :street_address_one, :street_address_two, :building_name, :phone_number).merge(user_id: current_user.id, status: 1)
  end


end
