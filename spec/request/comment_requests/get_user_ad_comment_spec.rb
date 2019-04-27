require 'rails_helper'

RSpec.describe 'GetUserAdComment', type: :request do
  let(:user)     { create(:user, :with_auth_token, id: 1)}

  let(:heading)  { create(:heading, user: user, id: 1) }

  let(:ad)       { create(:ad, user: user, heading: heading, id: 1) }

  let!(:comment) { create(:comment, ad: ad, user: user, id: 1) }

  let(:value)    { user.auth_token.value }

  let(:headers)  { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)   { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:resource_response) do
    {
      'ad' => { 'id' => ad.id },
      'author' => author,
      'id' => comment.id,
      'parent_id' => comment.parent_id,
      'text' => comment.text,
      'answers' => []
    }
  end

  context do
    before { get '/api/users/1/headings/1/ads/1/comments/1', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1/headings/1/ads/1/comments/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
