class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :request_type

      t.timestamps
    end
    add_foreign_key :requests, :users, colomn: :sender_id
    add_foreign_key :requests, :users, colomn: :receiver_id
  end
end
