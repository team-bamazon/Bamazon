class CartProductsController < ApplicationController

  def index
  end

  def create
    if CartProduct.find_by(product_id: cart_product_params[:product_id], cart_id: cart_product_params[:cart_id]).present?

      @cart_product = CartProduct.find_by(product_id: cart_product_params[:product_id], cart_id: cart_product_params[:cart_id])
      sum = @cart_product[:product_count] + cart_product_params[:product_count].to_i
      @cart_product.update(product_count: sum)
    else
      @cart_product = CartProduct.new(cart_product_params)
      @cart_product.save
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to edit_cart_path
  end

  private

  def cart_product_params
    # if user_signed_in?
    #   params.require(:cart_product).permit(:product_count).merge(cart_id: current_user.cart.id, product_id: params[:product_id])
    # else
    #   params.require(:cart_product).permit(:product_count).merge(cart_id: get_current_cart.id, product_id: params[:product_id])
    # end
    params.require(:cart_product).permit(:product_count).merge(cart_id: @cart.id, product_id: params[:product_id])
  end

end
