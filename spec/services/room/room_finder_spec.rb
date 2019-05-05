require 'rails_helper'

RSpec.describe Room::RoomFinder do
  let(:user)    { create(:user) }

  let(:commune) { create(:commune, creator: user) }

  let(:room)    { create(:room, commune: commune) }

  let(:params)         { { id: room.id, commune_id: commune.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  subject { Room::RoomFinder.new params: request_params }

  describe '#find.json' do
    let(:find) { subject.find }

    it { expect(find).to eq room }
  end
end
