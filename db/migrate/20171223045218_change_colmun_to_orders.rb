class ChangeColmunToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :card_number, :string
  end
end
