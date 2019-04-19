require 'rails_helper'

RSpec.describe 'GetUserResource', type: :request do
  let!(:user) { create(:user, :with_auth_token, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:user_response) do
    {
      "id" => user.id,
      "nickname" => user.nickname,
      "login" => user.login,
      "email" => user.email,
      "ads" => [],
      "readers" => [],
      "readables" => [],
      "commune" => ''
    }
  end

  context do
    before { get '/api/users/1', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq user_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record not found' do
    before { get '/api/users/0', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
