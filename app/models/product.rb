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
# 星が5の時の全体の割合を返す処理
  def rate_average_five
    if self.reviews.present?
      count = self.reviews.count
      # rateが10のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: 10).count
      # rate10のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end
  end
# 星が4の時の全体の割合を返す処理
  def rate_average_four
    if self.reviews.present?
      count = self.reviews.count
      # rateが8のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: 8).count
      # rate8のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end
  end
# 星が3の時の全体の割合を返す処理
  def rate_average_three
    if self.reviews.present?
      count = self.reviews.count
      # rateが6のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: 6).count
      # rate6のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end
  end
# 星が2の時の全体の割合を返す処理
  def rate_average_two
    if self.reviews.present?
      count = self.reviews.count
      # rateが4のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: 4).count
      # rate4のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end
  end
# 星が1の時の全体の割合を返す処理
  def rate_average_one
    if self.reviews.present?
      count = self.reviews.count
      # rateが2のものがいくつあるか探す処理
      star_value_sum = self.reviews.where(rate: 2).count
      # rate2のレビューの%をだす処理
      star_value = (star_value_sum * 100) / count
    else
      star_value = 0
    end
  end
end
