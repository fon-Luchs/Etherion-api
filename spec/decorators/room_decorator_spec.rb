require 'rails_helper'

RSpec.describe RoomDecorator do
  let(:user)     { create(:user, nickname: 'Lollita') }

  let(:commune)  { create(:commune, creator: user) }

  let(:room)     { create(:room, commune: commune) }

  subject        { room.decorate.as_json }

  its([:id])     { should eq room.id }

  its([:name])   { should eq room.name }

  its([:users])  { should eq [] }
end
