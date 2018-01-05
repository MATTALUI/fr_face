class ConversationsController < ApplicationController
  def index
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find(id)
    @conversations = assemble_conversations(id)
    @new_convo_friends = assemble_new_comvo_friends(id)
  end

  def show
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    return redirect_to root_path if params[:id].to_i == id
    @user = User.find(id)
    @conversations = assemble_conversations(id)
    @new_convo_friends = assemble_new_comvo_friends(id)
    @conversation_with = User.find(params[:id])
    @conversation = []
    from = Message.where({:sender_id => id, :receiver_id => @conversation_with[:id]})
    to = Message.where({:sender_id => @conversation_with[:id], :receiver_id => id})
    @conversation.concat(from)
    @conversation.concat(to)
    @conversation.sort! {|pa, pb|
      pa[:created_at] <=> pb[:created_at]
    }
    @conversation.each { |message|
      message.update({:read => true}) if not message[:read]
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
  def assemble_new_comvo_friends(id)
    friends = User.friends(id)
    friends.reject!{|friend| @conversations.index(friend) != nil}
    return friends
  end
end
