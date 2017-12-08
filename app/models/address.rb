class Address < ApplicationRecord
  belongs_to :users

  validates :country,:full_name,:postal_code_one,:postal_code_two, :region,:street_address_one, :phone_number, presence: true

  def simoketa
    simo = phone_number.split("")
    return simo[simo.length - 4]+simo[simo.length - 3]+simo[simo.length - 2]+simo[simo.length - 1]
  end

  def komesuu
    simo = phone_number.split("")
    return "*" * (simo.length - 4)
  end
end
