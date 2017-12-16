class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart, if: :user_signed_in?
  before_action :set_default_wanted, if: :user_signed_in?

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

  def set_default_wanted
    if current_user.wanteds.present?
      @default_wanted = Wanted.find_by(default_flg: true)
    else
      @default_wanted = Wanted.create(name: "ほしい物リスト", default_flg: true, open_flg: true, user_id: current_user.id)
    end
  end
end
