class ChangeDatatypeOfDetail < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :detail, :text, :limit => 16777215
  end
end
