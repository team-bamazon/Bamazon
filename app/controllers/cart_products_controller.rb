class CartProductsController < ApplicationController
  before_action :set_cart

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
  end

  private

  def set_cart
    if current_user.cart.present?
      @cart = Cart.find(current_user.cart.id)
    else
      @cart = Cart.create(user_id: current_user.id)
    end
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_count).merge(cart_id: @cart.id, product_id: params[:product_id] )
  end

end
