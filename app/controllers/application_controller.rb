class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart, if: :user_signed_in?

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :furigana])
  end

  def set_cart
    if current_user.cart.present?
      @cart = Cart.find(current_user.cart.id)
    else
      @cart = Cart.create(user_id: current_user.id)
    end
  end
end
