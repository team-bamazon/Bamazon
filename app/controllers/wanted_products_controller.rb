class WantedProductsController < ApplicationController
  def index
  end
# cart_productと同じような定義を記述
  def create
    if WantedProduct.find_by(product_id: wanted_product_params[:product_id], wanted_id: wanted_product_params[:wanted_id]).present?

      @wanted_product = WantedProduct.find_by(product_id: wanted_product_params[:product_id], wanted_id: wanted_product_params[:wanted_id])
      sum = @wanted_product[:product_count] + wanted_product_params[:product_count].to_i
      @cart_product.update(product_count: sum)

    else
      @wanted_product = WantedProduct.new(wanted_product_params)
      @wanted_product.save
    end
  end

  private

  def wanted_product_params
    params.require(:wanted_product).permit(:product_count).merge(wanted_id: @wanted.id, product_id: params[:product_id] )
  end
end
