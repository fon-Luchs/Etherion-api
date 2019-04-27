require 'rails_helper'

RSpec.describe 'PostUserAdComment', type: :request do
  let(:user)            { create(:user, :with_auth_token, id: 1)}

  let(:heading)         { create(:heading, user: user, id: 1) }

  let(:ad)              { create(:ad, user: user, heading: heading, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:params)          { { comment: { text: 'loller', user: user, ad: ad }, heading_id: heading.id, ad_id: ad.id } }

  let(:resource_params) { attributes_for(:comment) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)          { { 'id' => user.id, 'nickname' => user.nickname } }

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

  before { build(:comment, resource_params) }

  let(:comment) { Comment.last }

  context do
    before { post '/api/users/1/headings/1/ads/1/comments', params: params.to_json , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/headings/1/ads/1/comments', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    let(:params) { { comment: {}, user_id: user.id, heading_id: heading.id, ad_id: ad.id } }

    before { post '/api/users/1/headings/1/ads/1/comments', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
