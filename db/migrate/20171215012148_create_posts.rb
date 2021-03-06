class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id, index: true
      t.timestamps
    end
    add_foreign_key :posts, :users, on_delete: :cascade
  end
end
