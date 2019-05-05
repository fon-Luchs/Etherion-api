class Room::RoomFinder
  attr_reader :params

  def initialize(args = {})
    args ||= args

    @params = args[:params]
  end

  def find
    commune.rooms.find(params[:id])
  end

  private

  def commune
    @commune = Commune.find(params[:commune_id])
  end
end
