module Conversation::UserConversationsGetter
  def self.get_conversations(user = nil)
    Conversation.joins(:sender)
                .joins(:recipient)
                .where('conversations.recipient_id = ? or conversations.sender_id = ?', user.id, user.id)
  end
end
