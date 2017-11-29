class CreatePaymentInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_informations do |t|
      t.string  :card_name
      t.integer :card_number
      t.integer :month
      t.integer :year
      t.integer :security_code
      t.string  :card_company
      t.timestamps
    end
  end
end
