class Api::RoomUsersController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @room_user = Room::RoomUsers::RoomUserBuilder.new(params: params, current_user: current_user).build
  end

  def resource
    @room_user ||= Room::RoomUsers::RoomUserFinder.new(params: params, current_user: current_user).find
  end
end
