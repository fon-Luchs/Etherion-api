require 'rails_helper'

RSpec.describe 'PatchHeading', type: :request do
  let(:user)     { create(:user, :with_auth_token)}

  let!(:heading) { create(:heading, user: user, id: 1, name: 'новая') }

  let(:value)    { user.auth_token.value }

  let(:params)   { { heading: { name: 'другая' } } }

  let(:headers)  { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)   { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'id' => heading.id,
      'name' => Heading.first.name,
      'author' => author,
      'ads' => []
    }
  end

  context do
    before { patch '/api/profile/headings/1', params: params.to_json , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/profile/headings/1', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { patch '/api/profile/headings/0', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { patch '/api/profile/headings/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
