class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name,          :string, null: false
    add_column :users, :furigana,      :string
    add_column :users, :address,       :string
    add_column :users, :postal_code,   :string
    add_column :users, :language,      :string
    add_column :users, :points,        :integer
    add_column :users, :phone_number,  :string
    add_column :users, :profile,       :text
    add_column :users, :nickname,      :string
    add_column :users, :profile_image, :string
  end
end
