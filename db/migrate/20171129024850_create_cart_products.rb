class CreateCartProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_products do |t|
      t.integer :product_count
      t.timestamps
    end
  end
end
