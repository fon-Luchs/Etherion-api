require 'rails_helper'

RSpec.describe Room::RoomUsers::RoomUserFinder do
  let(:user)       { create(:user) }

  let(:commune)    { create(:commune, creator: user) }

  let(:room)       { create(:room, commune: commune) }

  let!(:room_user) { create(:room_user, room: room, user:user) }

  let(:params)     { { commune_id: commune.id, room_id: room.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  subject { Room::RoomUsers::RoomUserFinder.new params: request_params, current_user: user }

  describe '#find.json' do
    let(:find) { subject.find }

    it { expect(find.class.name).to eq 'RoomUser' }
  end
end
