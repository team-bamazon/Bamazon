class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_products, dependent: :destroy
  has_many   :addresses
  has_many   :payment_information
  def number_method
    return card_number[card_number.length-4, 4]
  end
end
