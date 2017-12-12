class ProductsController < ApplicationController

  def index
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
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

  private
  def set_cart
    if current_user.cart.present?
      @cart = Cart.find(current_user.cart.id)
    else
      @cart = Cart.create(user_id: current_user.id)
    end
  end
end


