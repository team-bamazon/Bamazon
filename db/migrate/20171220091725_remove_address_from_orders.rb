class RemoveAddressFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :address,        :string
    remove_column :orders, :postal_code,    :string
    remove_column :orders, :card_name,      :string
    remove_column :orders, :month,          :integer
    remove_column :orders, :year,           :integer
    remove_column :orders, :security_code,  :integer
    remove_column :orders, :card_company,   :string
  end
end
