class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search

  end
end
