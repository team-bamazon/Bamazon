class PaymentInformationsController < ApplicationController

  def index
    @card = PaymentInformation.new
    @cards = current_user.payment_informations
  end

  def create
    @card = PaymentInformation.new(payment_information_params)
    if @card.save
      redirect_to user_payment_informations_path(current_user)
    else
      flash.now[:alert] = "項目を全て記入してください"
      render :index
    end
  end

  def destroy
    payment_information = PaymentInformation.find(params[:id])
    payment_information.destroy if payment_information.user_id == current_user.id
    redirect_to user_payment_informations_path(current_user)
  end

  def edit
    @card = PaymentInformation.find(params[:id])
  end

  def update
    @card = PaymentInformation.find(params[:id])
    @card.update(payment_information_params)
    redirect_to user_payment_informations_path(current_user)
  end

  private
    def payment_information_params
      params.require(:payment_information).permit(:card_name, :card_number, :month, :year, :full_name, :postal_code_one, :postal_code_two, :region, :street_address_one, :street_address_two, :building_name, :phone_number).merge(user_id: current_user.id)
    end

end
