class CreateWantedProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :wanted_products do |t|
      t.integer    :product_count
      t.references :wanted,        null:false, foreign_key: true
      t.references :product,       null:false, foreign_key: true
      t.timestamps
    end
  end
end
