class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many   :review_comments

  def get_star
      star_value     = self.rate / 2.0
      star_value_css = self.rate.ceil

    return {star_value: star_value.round(1), star_value_css: star_value_css}
  end
end
