class CommuneDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :creator
  decorates_associations :rooms

  def as_json(*args)
    {
      id: object.id,
      name: object.name,
      author: { id: creator.id, nickname: creator.nickname },
      users: object.users.decorate(context: { user_index: true }).as_json,
      rooms: rooms.as_json
    }
  end
end
