class AddCountryToPaymentInformations < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_informations, :country, :string
    add_column :payment_informations, :postal_code_one, :string
    add_column :payment_informations, :postal_code_two, :string
    add_column :payment_informations, :region, :string
    add_column :payment_informations, :street_address_one, :string
    add_column :payment_informations, :street_address_two, :string
    add_column :payment_informations, :building_name, :string
    add_column :payment_informations, :phone_number, :string
    add_reference :payment_informations, :user, foreign_key: true
  end
end
