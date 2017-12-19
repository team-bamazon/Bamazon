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

  # @cartにuserに紐づいたcartをセットする処理。ログイン済状態でのみ呼ばれる関数。
  def set_cart
    # cartが作成済の場合（過去にログインしたことがあるユーザーの場合）の処理
    if current_user.cart.present?
      # 作成済みcartをuser_cartに設定
      @cart = current_user.cart
      user_cart = @cart

      # current_cart(未ログイン時に利用するカート)の存在有無で処理分岐
      # 存在する場合、中身を作成済cartに移す。
      current_cart = self.get_current_cart
      if current_cart.present?
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
              @cart_product = CartProduct.new(
                product_id: product.product_id,
                product_count: product.product_count,
                cart_id: user_cart.id
                )
              @cart_product.save
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
      if get_current_cart
        # current_cartにuser_idを設定し、永続的なcartにして@cartに設定
        @cart = get_current_cart
        @cart.update(user_id: current_user.id)
      # 未ログイン時に作成されたcurrent_cartが存在しない場合の処理（通常状態ではありえないはずの処理）
      else
        # userに紐づくcartを新規作成し、@cartに設定
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

  # 未ログイン時に利用するcartを@cartに設定する処理。ログイン時も未ログイン時も呼ばれうるが、未ログイン時のみ動く。ログイン時は何もしない。
  def set_current_cart
    # 未ログイン時のみ稼働
    unless user_signed_in?
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

  # session[:cart_id]に値がある場合（＝未ログイン時）に呼ばれた場合、そのcart_idでcartを探して返す。
  # ログイン時はnilを返すので、ログイン後に呼ぶ可能性がある箇所では呼び出し後にnil判定必須！！！
  def get_current_cart
    session[:cart_id].present? ? Cart.find(session[:cart_id]) : nil
  end

end
