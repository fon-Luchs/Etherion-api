class RoomDecorator < ApplicationDecorator
  delegate_all

  def as_json(*args)
    {
      id: object.id,
      name: object.name,
      users: []
    }
  end

end
