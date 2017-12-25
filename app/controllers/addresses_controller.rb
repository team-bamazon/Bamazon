class AddressesController < ApplicationController
  def new
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "addresses"
      @address = Address.new
    else
      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  def create
    @address = Address.create(address_params)
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "addresses"
      redirect_to user_edit_address_path
    else
      respond_to do |format|
        format.html
        format.json
      end
    end
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

  def update_status
    @address = Address.find(params[:id])
    @change_address = Address.find_by(status: 1)
    @address.update(status: 1)
    @change_address.update(status: 0)
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "addresses"
      redirect_to user_edit_address_path
    else
      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  private

  def address_params
    params.require(:address).permit(:country, :full_name, :postal_code_one, :postal_code_two, :region,:street_address_one, :street_address_two, :building_name, :phone_number).merge(user_id: params[:user_id])
  end
end
