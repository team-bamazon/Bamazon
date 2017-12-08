class ChangeColumnToPaymentInformations < ActiveRecord::Migration[5.1]
  def change
    change_column :payment_informations, :card_number, :string
  end
end
