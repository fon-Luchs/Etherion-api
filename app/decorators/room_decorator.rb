class RoomDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :messages

  def as_json(*args)
    if context[:room_index]
      {
        id: object.id,
        name: object.name,
        messages: messages.last.as_json || []
      }

    elsif context[:room_show]
      {
        id: object.id,
        name: object.name,
        commune: {
          id: room.commune.id,
          name: room.commune.name
        },
        users: room.users.decorate(context: { user_index: true }).as_json,
        messages: messages.order(created_at: :asc).as_json || []
      }
    end
  end
end
