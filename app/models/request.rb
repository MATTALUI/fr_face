class Request < ApplicationRecord
  belongs_to :requesters, class_name: "User", foreign_key: "sender_id"
  belongs_to :receivers, class_name: "User", foreign_key: "receiver_id"
end
