class Address < ApplicationRecord
  belongs_to :user
  belongs_to :order

  validates :country,:full_name,:postal_code_one,:postal_code_two, :region,:street_address_one, :phone_number, presence: true

  def last_four_digits
    return phone_number[phone_number.length - 4, 4]
  end

  def count_secret

    return "*" * (phone_number.length - 4)
  end
end
