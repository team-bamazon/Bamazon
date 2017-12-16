class AddOrderRefToOrderProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_products, :order, foreign_key: true
  end
end
