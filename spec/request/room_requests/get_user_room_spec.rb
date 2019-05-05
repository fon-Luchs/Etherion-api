require 'rails_helper'

RSpec.describe 'GetUserRoom', type: :request do
  let(:user)     { create(:user, :with_auth_token, id: 1)}

  let(:value)    { user.auth_token.value }

  let(:headers)  { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:commune)  { create(:commune, creator: user, id: 1) }

  let!(:room)    { create(:room, commune: commune, id: 1) }

  let(:resource_response) do
    {
      'id' => room.id,
      'name' => room.name,
      'users' => []
    }
  end

  context do
    before { get '/api/users/1/communes/1/rooms/1', params: {} , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1/communes/1/rooms/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { get '/api/users/1/communes/1/rooms/0', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
