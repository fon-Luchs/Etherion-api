require 'rails_helper'

RSpec.describe 'DeleteRoomUserProfile', type: :request do
  let(:user)    { create(:user, :with_auth_token) }

  let(:commune) { create(:commune, creator: user, id: 1) }

  let(:room)    { create(:room, commune: commune, id: 1) }

  let!(:room_user) { create(:room_user, user: user, room: room) }

  let(:value)      { user.auth_token.value }

  let(:headers)    { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/profile/communes/1/rooms/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/communes/1/rooms/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
