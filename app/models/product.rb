class Product < ApplicationRecord
  has_many   :cart_products
  has_many   :carts,            through: :cart_products
  has_many   :wanted_products
  has_many   :wanteds,          through: :wanted_products
  has_many   :product_images
  has_many   :reviews
  belongs_to :product_category

  accepts_nested_attributes_for :product_images

  paginates_per 24

  def cart_informations(cart)
    product.cart_products
  end

  def get_star_value
    # productインスタンスに紐づくreviewについたrateの平均値を返すメソッド
    # reviewがない場合はゼロを返す
    # 返す値は0-10の範囲の整数値
    if self.reviews.present?
      # countをfloat型で扱わせるために1.0をかけている
      count = self.reviews.count * 1.0
      star_value_sum = 0
      self.reviews.each do |r|
        star_value_sum += r.rate;
      end

      star_value     = (star_value_sum / count) / 2.0
      star_value_css = (star_value_sum / count).ceil
    else
      star_value     = 0.0
      star_value_css = 0
    end

    return {star_value: star_value.round(1), star_value_css: star_value_css}
  end

  # 星がrateの時の全体の割合を返す処理
  def rate_average(rate)
    if self.reviews.present?
      count = self.reviews.count
      # rateが2のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: rate).count
      # rate2のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end

    return star_value
  end
end
