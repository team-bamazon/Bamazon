class PaymentInformation < ApplicationRecord
  belongs_to :user
  validates :card_name, presence: true
  validates :card_number, presence: true
  validates :month, presence: true
  validates :year, presence: true
  validates :postal_code_one, presence: true
  validates :postal_code_two, presence: true
  validates :region, presence: true
  validates :street_address_one, presence: true
  validates :building_name, presence: true
  validates :phone_number, presence: true
  validates :full_name, presence: true

  def number_method
    number = card_number.split("")
    return  number[12] + number[13] + number[14] + number[15]
  end
end
