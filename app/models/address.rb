class Address < ApplicationRecord
  belongs_to :users

  validates :country,:full_name,:postal_code_one,:postal_code_two, :region,:street_address_one, :phone_number, presence: true
end
