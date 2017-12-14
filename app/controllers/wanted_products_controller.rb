class WantedProductsController < ApplicationController
  def update
    # wanted1からwanted2に移動する処理
    target_w_p = WantedProduct.find(params[:id])
    target_w_p.update(wanted_id: update_wanted_product_params[:wanted_id])

    # もともと開いていた欲しいものリストに戻る処理
    selected_wanted = Wanted.find(update_wanted_product_params[:selected_wanted_id])
    redirect_to user_wanted_path(current_user, selected_wanted)
  end

  def destroy
    # 削除機能を作りたい
  end

  private

  def update_wanted_product_params
    params.require(:wanted_product).permit(:wanted_id, :selected_wanted_id)
  end

end
