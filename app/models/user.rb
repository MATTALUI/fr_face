class User < ApplicationRecord
  has_many :posts
  has_many :requests_received, foreign_key: "receiver_id", class_name: "Request"
  has_many :requests_from, through: :requests_received, :source => :requesters
  has_many :requests_sent, foreign_key: "sender_id", class_name: "Request"
  has_many :messages_sent, foreign_key: "sender_id", class_name: "Message"
  has_many :messages_received, foreign_key: "receiver_id", class_name: "Message"
  has_many :unread_messages, -> { where({:read => false}) }, foreign_key: "receiver_id", class_name: "Message"
  has_many :comments_made, foreign_key: "user_id", class_name: "Comment"




  scope :friends, -> (id) {
    friends = []
    @friendships_1 = Friendship.where(:friend_1=>id)
    @friendships_2 = Friendship.where(:friend_2=>id)
    @friendships_1.each { |friendship|
      friends.push(User.find(friendship[:friend_2]))
    }
    @friendships_2.each { |friendship|
      friends.push(User.find(friendship[:friend_1]))
    }
    friends
  }


  validates :first_name, presence: true

  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX, message: 'Email is no good. :('}

  validates :password, presence: true
end
