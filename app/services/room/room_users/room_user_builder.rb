class Room::RoomUsers::RoomUserBuilder < Room::RoomUsers::RoomUserBase
  def build
    RoomUser.new room: room, user: user
  end
end
