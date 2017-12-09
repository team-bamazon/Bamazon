class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :full_name
      t.string :postal_code_one
      t.string :postal_code_two
      t.string :region
      t.string :street_address_one
      t.string :street_address_two
      t.string :building_name
      t.string :phone_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
