class Room::RoomBuilder
  attr_reader :params

  def initialize(args = {})
    args ||= args

    @params = args[:params]
  end

  def build
    commune.rooms.new(permitted_params)
  end

  private

  def commune
    @commune = Commune.find(params[:commune_id])
  end

  def permitted_params
    params.require(:room).permit(:name).merge(commune: commune)
  end
end
