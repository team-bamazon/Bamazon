class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart, if: :user_signed_in?
  before_action :set_default_wanted, if: :user_signed_in?
  before_action :set_current_cart
  helper_method :get_current_cart


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :furigana])
  end

  def set_cart
    if current_user.cart.present?
      @cart = current_user.cart
      user_cart = @cart
      binding.pry
      current_cart = self.get_current_cart
      # binding.pry
      if current_cart.present?
        # binding.pry
        if current_cart.cart_products.present?
          # binding.pry
          current_cart.cart_products.each do |product|
            if user_cart.cart_products.find_by(product_id: product.product_id).present?
              # binding.pry
              user_cart_product =  user_cart.cart_products.find_by(product_id: product.product_id)
              sum = user_cart_product.product_count + product.product_count
              user_cart_product.update(product_count: sum)
            else
              @cart_product = CartProduct.new(
                product_id: product.product_id,
                product_count: product.product_count,
                cart_id: user_cart.id
                )
              @cart_product.save
            end
          end
        end
        session[:cart_id] = nil
        binding.pry
        current_cart.destroy
      end
    else
      binding.pry
      if get_current_cart
        @cart = get_current_cart
        @cart.update(user_id: current_user.id)
      else
        @cart = Cart.create(user_id: current_user.id)
      end
    end
  end

  def set_default_wanted
    if current_user.wanteds.present?
      @default_wanted = Wanted.find_by(user_id: current_user.id, default_flg: true)
    else
      @default_wanted = Wanted.create(name: "ほしい物リスト", default_flg: true, open_flg: true, user_id: current_user.id)
    end
  end

  def set_current_cart
    unless user_signed_in?
      # binding.pry
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end
    end
  end

  def get_current_cart
    # binding.pry
    session[:cart_id].present? ? Cart.find(session[:cart_id]) : nil
  end

end
