class Api::RoomsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @room = Room::RoomBuilder.new(params: params).build
  end

  def resource
    @room ||= Room::RoomFinder.new(params: params).find
  end

  def resource_params
    params.require(:room).permit(:name)
  end
end
