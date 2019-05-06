class RoomUserDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :room

  decorates_associations :user

  def as_json(*args)
    {
      status: "Welcome to #{room.name}",
      name: room.name,
      commune: {
        id: room.commune.id,
        name: room.commune.name
      },
      users: room.users.decorate(context: { user_index: true }).as_json
    }
  end
end
