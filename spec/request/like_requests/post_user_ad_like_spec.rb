require 'rails_helper'

RSpec.describe 'PostUserAdLike', type: :request do
  let(:user)            { create(:user, :with_auth_token)}

  let(:another)         { create(:user) }

  let(:heading)         { create(:heading, user: another, id: 1) }

  let(:ad)              { create(:ad, user: another, heading: heading, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:params)          { { like: { kind: 0 }, user_id: user.id, ad_id: ad.id, heading_id: heading.id } }

  let(:resource_params) { attributes_for(:like) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      'kind' => like.kind
    }
  end

  before { build(:like, resource_params.merge(user: user)) }

  let(:like) { Like.last }

  context do
    before { post '/api/users/1/headings/1/ads/1/like', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/headings/1/ads/1/like', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/users/1/headings/1/ads/1/like', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
