class RemoveProductCountFromWantedProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :wanted_products, :product_count, :integer
  end
end
