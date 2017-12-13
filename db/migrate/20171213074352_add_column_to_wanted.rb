class AddColumnToWanted < ActiveRecord::Migration[5.1]
  def change
    add_reference :wanteds, :user, foreign_key: true
  end
end
