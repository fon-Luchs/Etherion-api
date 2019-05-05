class RoomDecorator < ApplicationDecorator
  delegate_all

  def as_json(*args)
    {
      id: object.id,
      name: object.name,
      commune: {
        id: room.commune.id,
        name: room.commune.name
      },
      users: []
    }
  end

end
