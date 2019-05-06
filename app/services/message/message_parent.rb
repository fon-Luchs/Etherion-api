module Message::MessageParent
  def self.call(params = {})
    parent = Room.find(params[:room_id]) if params[:room_id]
    parent = Conversation.find(params[:conversation_id]) if params[:conversation_id]
    parent
  end
end
