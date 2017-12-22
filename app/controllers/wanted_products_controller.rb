class WantedProductsController < ApplicationController
  def create
    @params = params

    if WantedProduct.find_by(product_id: params[:product_id], wanted_id: @default_wanted.id).blank?
      WantedProduct.create(product_id: params[:product_id], wanted_id: @default_wanted.id)
    end

    redirect_to user_wanted_path(current_user, @default_wanted)
  end

  def update
    # wanted1からwanted2に移動する処理
    target_w_p = WantedProduct.find(params[:id])
    target_w_p.update(wanted_id: update_wanted_product_params[:wanted_id])

    # もともと開いていた欲しいものリストに戻る処理
    selected_wanted = Wanted.find(update_wanted_product_params[:selected_wanted_id])
    redirect_to user_wanted_path(current_user, selected_wanted)
  end

  def destroy
    target_w_p = WantedProduct.find(params[:id])
    target_w_p.delete

    # もともと開いていた欲しいものリストに戻る処理
    selected_wanted = Wanted.find(params[:selected_wanted_id])
    redirect_to user_wanted_path(current_user, selected_wanted)
  end

  private

  def update_wanted_product_params
    params.require(:wanted_product).permit(:wanted_id, :selected_wanted_id)
  end

end
