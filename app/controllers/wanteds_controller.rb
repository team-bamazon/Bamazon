class WantedsController < ApplicationController
  def show
    # create用のフォームがあるのでここでnewする。
    @new_wanted = Wanted.new(name:"ほしい物リスト")

    @wanteds = User.find(params[:user_id]).wanteds
    @selected_wanted = Wanted.find(params[:id])

    @selected_wanted_products = @selected_wanted.products
    @selected_id = @selected_wanted.id
    @user_id = params[:user_id]

    if @selected_wanted.wanted_products.present?
      @update_datetimes = Hash[@selected_wanted.wanted_products.map{|wp| [wp.product_id, wp.updated_at.strftime("%m月 %d %Y")]}]
    end
  end
end
