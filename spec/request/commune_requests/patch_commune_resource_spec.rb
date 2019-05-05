require 'rails_helper'

RSpec.describe 'PatchCommune', type: :request do
  let(:user)     { create(:user, :with_auth_token)}

  let(:value)    { user.auth_token.value }

  let(:params)   { { commune: { name: 'другая' } } }

  let(:headers)  { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)   { { 'id' => user.id, 'nickname' => user.nickname } }

  let!(:commune) { create(:commune, creator: user, id: 1) }

  let(:author)   { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => commune.id,
      'name' => Commune.last.name,
      'author' => author,
      'rooms' => [],
      'users' => [author]
    }
  end

  context do
    before { patch '/api/profile/communes/1', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/profile/communes/1', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { patch '/api/profile/communes/0', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
