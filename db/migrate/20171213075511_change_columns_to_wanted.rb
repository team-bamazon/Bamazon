class ChangeColumnsToWanted < ActiveRecord::Migration[5.1]
  def change
    change_column :wanteds, :default_flg, :boolean, null: false
    change_column :wanteds, :open_flg,    :boolean, null: false
  end
end
