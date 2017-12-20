class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_products, dependent: :destroy
  has_many   :addresses
  has_many   :payment_information
end
