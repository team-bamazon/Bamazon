class WantedsController < ApplicationController
  def index
    @wanteds = User.find(params[:user_id]).wanteds
  end

  def show

  end
end
