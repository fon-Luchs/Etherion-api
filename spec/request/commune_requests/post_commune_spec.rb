require 'rails_helper'

RSpec.describe 'PostCommune', type: :request do
  let(:user)   { create(:user, :with_auth_token)}

  let(:value)  { user.auth_token.value }

  let(:params) { { commune: { name: 'loller', creator: user } } }

  let(:resource_params) { attributes_for(:commune) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)          { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => commune.id,
      'name' => commune.name,
      'author' => author,
      'chats' => [],
      'users' => [author]
    }
  end

  before { build(:commune, resource_params) }

  let(:commune) { Commune.last }

  context do
    before { post '/api/profile/communes', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/communes', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/communes', params: {} , headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
