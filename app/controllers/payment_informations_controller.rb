class PaymentInformationsController < ApplicationController

  def index
  end

  def create
  end

  private
  def payment_information_params
    params.require(:payment_information).permit(:card_name, :card_number, :month, :year, :full_name, :postal_code_one, :postal_code_two, :region, )
  end

end
