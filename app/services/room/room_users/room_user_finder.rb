class Room::RoomUsers::RoomUserFinder < Room::RoomUsers::RoomUserBase
  def find
    RoomUser.find_by!(user: user, room: room)
  end
end
