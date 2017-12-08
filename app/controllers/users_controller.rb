class UsersController < ApplicationController

  before_action :set_payment_information, only: [:index, :create]

  def index
    @card = Payment_information.new
  end

  def create
    @card = Payment_information.new(params[:id])
  end

  def edit
  end

  private
  def payment_information_params
    params.require(:payment_information).permit(:card_name, :country, :).merge(group_id: params[:group_id], user_id: current_user.id)
  end

  def set_payment_information
    @user = User.find(params[:id])
  end
end
