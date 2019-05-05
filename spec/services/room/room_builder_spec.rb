require 'rails_helper'

RSpec.describe Room::RoomBuilder do
  let(:user)    { create(:user) }

  let(:commune) { create(:commune, creator: user) }

  let(:params)         { { room: { name: 'ZZZXXX' }, commune_id: commune.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  subject { Room::RoomBuilder.new params: request_params }

  describe '#builde.json' do
    let(:build) { subject.build }

    it { expect(build.class.name).to eq 'Room' }
  end
end
