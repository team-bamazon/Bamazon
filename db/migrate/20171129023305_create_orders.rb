class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string  :address
      t.string  :postal_code
      t.string  :phone_number
      t.string  :card_name
      t.integer :card_number
      t.integer :month
      t.integer :year
      t.integer :security_code
      t.string  :card_company
      t.integer :status
      t.timestamps
    end
  end
end
