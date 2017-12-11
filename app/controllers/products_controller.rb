class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def search
    @products = Product.where('name LIKE(?)', "%#{params[:field_keywords]}%")
  end

  def suggest
    @suggests = Product.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.json
    end
  end
end
