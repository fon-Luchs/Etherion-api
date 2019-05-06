require 'rails_helper'

RSpec.describe 'PostCommuneRoomMessage', type: :request do
  let(:user)      { create(:user, :with_auth_token) }

  let(:recipient) { create(:user) }

  let(:commune)   { create(:commune, creator: user, id: 1) }

  let!(:room)     { create(:room, commune: commune, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params)          { { message: resource_params } }

  let(:resource_params) { attributes_for(:message) }

  let(:author) do
    {
      'id' => user.id,
      'nickname' => user.nickname
    }
  end

  let(:resource_response) do
    {
      'id' => message.id,
      'text' => message.text,
      'author' => author
    }
  end

  before { build(:message, resource_params.merge(user: user, messageable: room) ) }

  let(:message) { Message.last }

  context do
    before { post '/api/profile/communes/1/rooms/1/messages', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/communes/1/rooms/1/messages', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { post '/api/profile/communes/1/rooms/0/messages', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { post '/api/profile/communes/1/rooms/1/messages', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
