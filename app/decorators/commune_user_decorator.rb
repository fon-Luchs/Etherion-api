class CommuneUserDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :commune

  def as_json(*args)
    {
      status: "Welcome to #{commune.name}",
      chats: [],
      author: { id: commune.creator.id, nickname: commune.creator.nickname },
      users: commune.users.decorate(context: { user_index: true }).as_json
    }
  end
end
