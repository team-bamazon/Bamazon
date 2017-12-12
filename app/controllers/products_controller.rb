class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
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
