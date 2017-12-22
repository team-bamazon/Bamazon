class AddColumnToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :country,               :string
    add_column :orders, :full_name,             :string
    add_column :orders, :postal_code_one,       :string
    add_column :orders, :postal_code_two,       :string
    add_column :orders, :region,                :string
    add_column :orders, :street_address_one,    :string
    add_column :orders, :street_address_two,    :string
    add_column :orders, :building_name,         :string
    add_column :orders, :card_name,             :string
    add_column :orders, :month,                 :integer
    add_column :orders, :year,                  :integer
    add_column :orders, :security_code,         :integer
    add_column :orders, :card_company,          :string
  end
end
