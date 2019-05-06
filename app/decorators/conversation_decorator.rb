class ConversationDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :sender
  decorates_associations :recipient
  decorates_associations :messages

  def as_json(*args)
    if context[:user_id] == sender.id
      {
        id: object.id,
        nickname: recipient.nickname,
        messages: messages.order(created_at: :asc).as_json
      }
    elsif context[:user_id] == recipient.id
      {
        id: object.id,
        nickname: sender.nickname,
        messages: messages.order(created_at: :asc).as_json
      }
    elsif context[:conversations_index]
      {
        id: object.id,
        nickname: context[:user_id] == sender.id ? sender.nickname : recipient.nickname,
        last_message: messages.last.as_json
      }
    end
  end
end
