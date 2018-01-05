class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :body
      t.boolean :read, :default => false

      t.timestamps
    end

    add_foreign_key :messages, :users, colomn: :sender_id
    add_foreign_key :messages, :users, colomn: :receiver_id

  end
end
