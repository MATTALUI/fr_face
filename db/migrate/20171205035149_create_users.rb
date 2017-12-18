class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email, index: true
      t.string :password
      t.text :description
      t.string :user_image, :default => "https://i.pinimg.com/236x/9f/81/2d/9f812d4cf313e887ef99d8722229eee1--facebook-profile-profile-pictures.jpg"
      t.string :gender


      t.timestamps
    end
  end
end
