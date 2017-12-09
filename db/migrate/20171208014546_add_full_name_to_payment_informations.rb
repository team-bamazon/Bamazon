class AddFullNameToPaymentInformations < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_informations, :full_name, :string
  end
end
