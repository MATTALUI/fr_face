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
    return redirect_to root_path if params[:id].to_i == id
    @user = User.find(id)
    @conversations = assemble_conversations(id)
    @conversation_with = User.find(params[:id])
    @conversation = []
    from = Message.where({:sender_id => id, :receiver_id => @conversation_with[:id]})
    to = Message.where({:sender_id => @conversation_with[:id], :receiver_id => id})
    @conversation.concat(from)
    @conversation.concat(to)
    @conversation.sort! {|pa, pb|
      pa[:created_at] <=> pb[:created_at]
    }

  end

  private
  def assemble_conversations(id)
    me = User.find(id)
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
    conversations.reject!{|user| user == me}
    return conversations
  end
end
