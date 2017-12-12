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

  def search
    @search_keyword = params[:field_keywords]
    @products = Product.where('name LIKE(?)', "%#{@search_keyword}%").page(params[:page])
  end

  def suggest
    @suggests = Product.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.json
    end
  end
end


