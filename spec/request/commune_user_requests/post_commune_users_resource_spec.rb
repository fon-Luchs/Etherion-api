require 'rails_helper'

RSpec.describe 'PostCommuneUserResource', type: :request do
  let(:user)    { create(:user, :with_auth_token)}

  let(:another) { create(:user, id: 1) }

  let(:commune) { create(:commune, creator: another, id: 1) }

  let(:value)   { user.auth_token.value }

  let(:params)  { { commune_user: { commune: commune, user: user }, user_id: another.id, commune_id: commune.id } }

  let(:resource_params) { attributes_for(:commune_user) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)          { { 'id' => another.id, 'nickname' => another.nickname } }

  let(:resource_response) do
    {
      'status' => "Welcome to #{commune.name}",
      'author' => author,
      'chats' => [],
      'users' => User.all.map { |u| { 'id' => u.id, 'nickname' => u.nickname } }
    }
  end

  before { build(:commune_user, resource_params) }

  let(:commune_user) { CommuneUSer.last }

  context do
    before { post '/api/users/1/communes/1/join', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/communes/1/join', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
