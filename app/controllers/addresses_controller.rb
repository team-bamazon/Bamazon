class AddressesController < ApplicationController
  def new
    @address = Address.new
    # 下記のはいらないと思い削除
    # path = Rails.application.routes.recognize_path(request.referer)
    # if path[:controller] == "addresses"
    #   @address = Address.new
    # else
    #   respond_to do |format|
    #     format.html
    #     format.json
    #   end
    # end
  end

  def create
    @change_address = Address.find_by(status: 1, user_id: current_user.id)
    @change_address.update(status: 0) if @change_address.present?
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
    # user_idもないと他の人のアドレスが取られる可能性があるので一応
    @change_address = Address.find_by(status: 1, user_id: current_user.id)
    @address.update(status: 1)
    # @change_addressが空のことも考えられるのでif分岐追加
    @change_address.update(status: 0) if @change_address.present?
    path = Rails.application.routes.recognize_path(request.referer)
    # addressではなくusersだったので変更
    if path[:controller] == "users"
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
    params.require(:address).permit(:country, :full_name, :postal_code_one, :postal_code_two, :region,:street_address_one, :street_address_two, :building_name, :phone_number, :status).merge(user_id: params[:user_id])
    # アドレスが作られる時にstatusも保存しておいた方がいいので追加
  end
end
