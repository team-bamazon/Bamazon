class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  before_action :set_default_wanted, if: :user_signed_in?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :furigana])
  end

  # @cartにuserに紐づいたcartをセットする処理。
  # 未ログイン時にはセッション内で使う一時的なcartを作る。カートIDをsession[:cart_id]に保存しておく。
  # ログイン時は作成済cartがあればそれを@cartにセットする。そのさい、一時的なcartがあれば内容を@cartに持っていく。
  def set_cart
    if user_signed_in?
      # cartが作成済の場合（過去にログインしたことがあるユーザーの場合）の処理
      if current_user.cart.present?
        # 作成済みcartをuser_cartに設定
        @cart = current_user.cart
        user_cart = @cart

        # current_cart(未ログイン時に利用するカート)の存在有無で処理分岐
        # 存在する場合、中身を作成済cartに移す。
        if self.has_current_cart?
          current_cart = Cart.find(session[:cart_id])
          # current_cart(未ログイン時に利用するカート)の中身あったらcartに移す、空だったら何もしない
          if current_cart.cart_products.present?
            current_cart.cart_products.each do |product|
              # current_cart(未ログイン時に利用するカート)の中身が作成済cartにもある場合、作成済cartの中の個数を増やす
              if user_cart.cart_products.find_by(product_id: product.product_id).present?
                user_cart_product =  user_cart.cart_products.find_by(product_id: product.product_id)
                sum = user_cart_product.product_count + product.product_count
                user_cart_product.update(product_count: sum)
              # current_cart(未ログイン時に利用するカート)の中身が作成済cartにない場合、作成済cartにproductを入れる
              else
                cart_product = CartProduct.new(
                  product_id: product.product_id,
                  product_count: product.product_count,
                  cart_id: user_cart.id
                  )
                cart_product.save
              end
            end
          end

          # cartに中身を移したら、current_cart(未ログイン時に利用するカート)はもう不要なので削除。
          session[:cart_id] = nil
          current_cart.destroy
        end
      # cartが未作成の場合（今回が初回ログインのユーザーの場合）の処理
      else
        # 未ログイン時に作成されたcurrent_cartが存在する場合の処理
        if self.has_current_cart?
          # current_cartにuser_idを設定し、永続的なcartにして@cartに設定
          @cart = Cart.find(session[:cart_id])
          @cart.update(user_id: current_user.id)
          session[:cart_id] = nil
        # 未ログイン時に作成されたcurrent_cartが存在しない場合の処理（通常状態ではありえないはずの処理）
        else
          # userに紐づくcartを新規作成し、@cartに設定
          @cart = Cart.create(user_id: current_user.id)
        end

        current_user.cart = @cart
      end
    else
      # このセッション中で既に作成したcartがある場合（session[:cart_id]に値が入っている場合）、それを@cartに設定する
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
        # このセッション中で作成したcartが無い場合（このセッションで初めてこの処理を呼ぶ場合）、cartを作成し@cartとsession[:cart_id]にcart_idを設定する。
      else
        @cart = Cart.create
        session[:cart_id] = @cart.id
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

  def has_current_cart?
    session[:cart_id].present?
  end

end
