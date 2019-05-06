require 'rails_helper'

RSpec.describe RoomDecorator do
  let(:user)     { create(:user, nickname: 'Lollita') }

  let(:commune)  { create(:commune, creator: user) }

  let(:room)     { create(:room, commune: commune) }

  describe '#room_index' do
    subject { room.decorate(context: { room_index: true }).as_json }

    its([:id])       { should eq room.id }

    its([:name])     { should eq room.name }

    its([:messages]) { should eq [] }
  end

  describe '#room_show' do
    subject { room.decorate(context: { room_show: true }).as_json }

    its([:id])       { should eq room.id }

    its([:name])     { should eq room.name }

    its([:messages]) { should eq [] }

    its([:commune])  { should eq commune_response }
  end

  def commune_response
    {
      id: commune.id,
      name: commune.name
    }
  end
end
