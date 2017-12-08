class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.create(address_params)
    redirect_to user_edit_address_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy if address.user_id == current_user.id
    redirect_to user_edit_address_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to user_edit_address_path
  end

  private

  def address_params
    params.require(:address).permit(:country, :full_name, :full_name, :postal_code_one, :postal_code_two, :region,:street_address_one, :street_address_two, :building_name, :phone_number).merge(user_id: params[:user_id])
  end
end
