require 'rails_helper'

RSpec.describe RoomUserDecorator do
  let(:user)     { create(:user, nickname: 'Lollita') }

  let(:commune)  { create(:commune, creator: user) }

  let(:room)     { create(:room, commune: commune) }

  let(:room_user) { create(:room_user, room: room, user: user) }

  subject         { room_user.decorate.as_json }

  its([:name])    { should eq room.name }

  its([:commune]) { should eq commune_response }

  its([:users])   { should eq [{ id: user.id, nickname: user.nickname }] }

  def commune_response
    {
      id: commune.id,
      name: commune.name
    }
  end
end
