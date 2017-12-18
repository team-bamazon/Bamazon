class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review  = Review.new(user_id: current_user.id, product_id: params[:product_id])
  end

  def create
    @name = Product.find(params[:product_id]).name
    Review.create(review_params)

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rate).merge(product_id: params[:product_id]).merge(user_id: current_user.id)
  end
end
