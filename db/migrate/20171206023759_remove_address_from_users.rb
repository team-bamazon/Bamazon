class RemoveAddressFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :address
    remove_column :users, :postal_code
  end
end
