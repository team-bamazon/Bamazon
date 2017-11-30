class CreateWanteds < ActiveRecord::Migration[5.1]
  def change
    create_table :wanteds do |t|
      t.string  :name, null: false
      t.integer :default_flg
      t.integer :open_flg
      t.timestamps
    end
  end
end
