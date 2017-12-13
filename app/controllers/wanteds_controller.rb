class WantedsController < ApplicationController
  def show
    @wanteds = User.find(params[:user_id]).wanteds
    @selected_wanted = Wanted.find(params[:id])

    @wanted_products = @selected_wanted.products
    @selected_id = @selected_wanted.id
    @user_id = params[:user_id]
  end
end
