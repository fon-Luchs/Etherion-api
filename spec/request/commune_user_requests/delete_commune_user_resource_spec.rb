require 'rails_helper'

RSpec.describe 'DeleteCommuneUSerResource', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:another) { create(:user, id: 1) }

  let(:commune) { create(:commune, creator: another, id: 1) }

  let(:value)   { user.auth_token.value }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  before { create(:commune_user, commune: commune, user: user) }

  context do
    before { delete '/api/users/1/communes/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/users/1/communes/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
