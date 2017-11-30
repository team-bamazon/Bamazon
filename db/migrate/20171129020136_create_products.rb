class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string  :name, null: false, index: true
      t.float   :price, null: false
      t.string  :detail
      t.integer :stock
      t.integer :amount_sales
      t.timestamps
    end
  end
end
