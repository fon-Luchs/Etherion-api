require 'rails_helper'

RSpec.describe 'PostAd', type: :request do
  let(:user)            { create(:user, :with_auth_token)}

  let(:heading)         { create(:heading, user: user, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:params)          { { ad: { text: 'loller', user: user, heading: heading } } }

  let(:resource_params) { attributes_for(:ad) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)          { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => ad.id,
      'text' => ad.text,
      'author' => author
    }
  end

  before { build(:ad, resource_params) }

  let(:ad) { Ad.last }

  context do
    before { post '/api/profile/headings/1/ads', params: params.to_json , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/headings/1/ads', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
  
  context 'invalid params' do
    before { post '/api/profile/headings/1/ads', params: {} , headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
