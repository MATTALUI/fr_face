class Comment < ApplicationRecord
  belongs_to :post, foreign_key: "post_id", class_name: "Post"
  belongs_to :poster, foreign_key: "user_id", class_name: "User"
end
