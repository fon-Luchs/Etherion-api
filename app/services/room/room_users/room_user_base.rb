class Room::RoomUsers::RoomUserBase
  attr_reader :params, :current_user

  def initialize(args = {})
    args ||= args

    @params = args[:params]

    @current_user = args[:current_user]
  end

  protected

  def commune
    @commune = Commune.find_by!(creator_id: user.id, id: params[:commune_id])
  end

  def room
    @room = commune.rooms.find(params[:room_id])
  end

  def user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end
end
