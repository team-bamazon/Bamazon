class ProductsController < ApplicationController
  before_action :set_cart, only: [:index, :show]

  def index
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
  end

  private
  def cart_params
    params.merge(cart_id: current_user.cart.id)
  end

  def set_cart
    @cart = Cart.find(cart_params[:cart_id])
  end
end


