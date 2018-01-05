class ConversationsController < ApplicationController
  def index
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find(id)
    @conversations = assemble_conversations(id)
  end
  def show
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find(id)
  end

  private
  def assemble_conversations(id)
    conversations = []
    sent = Message.where({:sender_id => id})
    sent.each { |message|
      in_array = (conversations.index(message.sender) != nil)
      conversations.push(message.sender) if not in_array
    }
    received = Message.where({:receiver_id => id})
    received.each { |message|
      in_array = (conversations.index(message.sender) != nil)
      conversations.push(message.sender) if not in_array
    }
    return conversations
  end
end
