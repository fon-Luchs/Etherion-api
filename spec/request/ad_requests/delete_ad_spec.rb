require 'rails_helper'

RSpec.describe 'DeleteAd', type: :request do
  let(:user)    { create(:user, :with_auth_token)}

  let(:heading) { create(:heading, user: user, id: 1) }

  let!(:ad)     { create(:ad, user: user, heading: heading, id: 1) }

  let(:value)   { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/profile/headings/1/ads/1', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/headings/1/ads/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { delete '/api/profile/headings/0/ads/1', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'Record was not found' do
    before { delete '/api/profile/headings/1/ads/0', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
