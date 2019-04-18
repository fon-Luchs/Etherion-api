require 'rails_helper'

RSpec.describe 'GetProfile', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:profile_response) do
    {
      "id" => user.id,
      "nickname" => user.nickname,
      "login" => user.login,
      "email" => user.email,
      "ads" => [],
      "readers" => [],
      "readables" => [],
      "commune" => '',
      "letters" => [],
      "polit_rate" => 0
    }
  end

  context do
    before { get '/api/profile', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq profile_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
