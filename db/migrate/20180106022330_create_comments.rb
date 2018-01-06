class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
    add_foreign_key :comments, :users, colomn: :user_id
    add_foreign_key :comments, :posts, colomn: :post_id
  end
end
