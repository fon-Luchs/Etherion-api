require 'rails_helper'

RSpec.describe 'PostProfileCommentAnswer', type: :request do
  let(:user)            { create(:user, :with_auth_token)}

  let(:heading)         { create(:heading, user: user, id: 1) }

  let(:ad)              { create(:ad, user: user, heading: heading, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:params)          { { comment: { text: 'loller', user: user, ad: ad }, heading_id: heading.id, ad_id: ad.id, parent_id: 1} }

  let(:resource_params) { attributes_for(:comment) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)          { { 'id' => user.id, 'nickname' => user.nickname } }

  let(:comment)         { create(:comment, user: user, ad: ad, id: 1) }

  let(:resource_response) do
    {
      'ad' => { 'id' => ad.id },
      'author' => author,
      'id' => answer.id,
      'parent_id' => comment.id,
      'text' => answer.text,
      'answers' => []
    }
  end

  before { build(:comment, resource_params.merge(parent_id: comment.id)) }

  let(:answer) { Comment.last }

  context do
    before { post '/api/profile/headings/1/ads/1/comments/1/answers', params: params.to_json , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/headings/1/ads/1/comments/1/answers', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    let(:params) { { comment: {}, heading_id: heading.id, ad_id: ad.id } }

    before { post '/api/profile/headings/1/ads/1/comments/1/answers', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
