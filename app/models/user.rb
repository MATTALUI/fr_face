class User < ApplicationRecord
  has_many :posts


  validates :first_name, presence: true

  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX, message: 'Email is no good. :('}

  validates :password, presence: true
end
