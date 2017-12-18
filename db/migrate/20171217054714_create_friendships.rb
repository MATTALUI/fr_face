class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :friend_1, index: true
      t.integer :friend_2, index: true

      t.timestamps
    end
    add_foreign_key :friends, :users, colomn: :friend_1
    add_foreign_key :friends, :users, colomn: :friend_2
  end
end
