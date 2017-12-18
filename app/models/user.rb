class User < ApplicationRecord
  has_many :posts
  # has_many :friendships
  # has_many :friends, through: :friendships
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
    puts friends
    friends
  }


  validates :first_name, presence: true

  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX, message: 'Email is no good. :('}

  validates :password, presence: true
end
