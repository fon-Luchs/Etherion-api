require 'rails_helper'

RSpec.describe 'GetAdResource', type: :request do
  let(:user)    { create(:user, :with_auth_token)}

  let(:heading) { create(:heading, user: user, id: 1) }

  let!(:ad)     { create(:ad, user: user, heading: heading, id: 1) }

  let(:value)   { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)  { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => ad.id,
      'author' => author,
      'text' => ad.text
    }
  end

  context do
    before { get '/api/profile/headings/1/ads/1', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/headings/1/ads/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { get '/api/profile/headings/0/ads/1', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'Record was not found' do
    before { get '/api/profile/headings/1/ads/0', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
