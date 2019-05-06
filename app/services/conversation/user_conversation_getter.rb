module Conversation::UserConversationGetter
  def self.get_conversation(cu = nil, id = nil)
    conv = Conversation.find(id)
    [conv.sender, conv.recipient].include?(cu) ? conv : raise(ActiveRecord::RecordNotFound)
  end
end
