class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.string     :product_name
      t.float      :price
      t.string     :product_image
      t.integer    :count
      t.timestamps
    end
  end
end
