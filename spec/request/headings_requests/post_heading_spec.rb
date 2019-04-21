require 'rails_helper'

RSpec.describe 'PostHeading', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:params) { { heading: { name: 'loller', user: user } } }

  let(:resource_params) { attributes_for(:heading) }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author) { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => heading.id,
      'name' => heading.name,
      'author' => author,
      'ads' => []
    }
  end

  before { build(:heading, resource_params) }

  let(:heading) { Heading.last }

  context do
    before { post '/api/profile/headings', params: params.to_json , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/headings', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/headings', params: {} , headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
