class CreateReviewComments < ActiveRecord::Migration[5.1]
  def change
    create_table :review_comments do |t|
      t.text :body, null: false
      t.timestamps
    end
  end
end
