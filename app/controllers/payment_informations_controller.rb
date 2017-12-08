class PaymentInformationsController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @card = PaymentInformation.new
  end

  def create
    @card = PaymentInformation.new(payment_information_params)
    if @card.save
      redirect_to payment_informations_path(current_user)
    else
      flash.now[:alert] = "項目を全て記入してください"
      render :index
    end
  end

  private
    def payment_information_params
      params.require(:payment_information).permit(:card_name, :card_number, :month, :year, :full_name, :postal_code_one, :postal_code_two, :region, :street_address_one, :street_address_two, :building_name, :phone_number).merge(user_id: current_user.id)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
