require 'rails_helper'

RSpec.describe Room::RoomUsers::RoomUserBuilder do
  let(:user)    { create(:user) }

  let(:commune) { create(:commune, creator: user) }

  let(:room)    { create(:room, commune: commune) }

  let(:params)  { { commune_id: commune.id, room_id: room.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  subject { Room::RoomUsers::RoomUserBuilder.new params: request_params, current_user: user }

  describe '#builde.json' do
    let(:build) { subject.build }

    it { expect(build.class.name).to eq 'RoomUser' }
  end
end
