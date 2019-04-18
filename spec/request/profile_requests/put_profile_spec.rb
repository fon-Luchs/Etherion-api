require 'rails_helper'

RSpec.describe 'PutProfile', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { user: resource_params } }

  let(:resource_params) { attributes_for(:user) }

  let(:profile_response) do
    {
      "id" => user.id,
      "nickname" => User.last.nickname,
      "login" => User.last.login,
      "email" => User.last.email,
      "ads" => [],
      "readers" => [],
      "readables" => [],
      "commune" => '',
      "letters" => [],
      "polit_rate" => 0
    }
  end

  context do
    before { put '/api/profile', params: params.to_json, headers: headers }

    it('returns updated_profile') { expect(JSON.parse(response.body)).to eq profile_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid attributes' do
    before { put '/api/profile', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { put '/api/profile', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
