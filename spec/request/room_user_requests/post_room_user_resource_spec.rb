require 'rails_helper'

RSpec.describe 'PostRoomUserResource', type: :request do
  let(:user)     { create(:user, :with_auth_token, id: 1)}

  let(:value)    { user.auth_token.value }

  let(:headers)  { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:commune)  { create(:commune, creator: user, id: 1) }

  let(:room)     { create(:room, commune: commune, id: 1) }

  let(:params)   { { commune_id: commune.id, room_id: room.id } }

  let(:resource_params) { attributes_for(:room_user) }

  let(:resource_response) do
    {
      'name' => room.name,
      'status' => "Welcome to #{room.name}",
      'commune' => { 'id' => commune.id, 'name' => commune.name },
      'users' => [{ 'id' => user.id, 'nickname' => user.nickname }]
    }
  end

  before { build(:room_user, resource_params) }

  let(:room_user) { RoomUser.first }

  context do
    before { post '/api/users/1/communes/1/rooms/1/join', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/communes/1/rooms/1/join', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { post '/api/users/1/communes/1/rooms/0/join', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
