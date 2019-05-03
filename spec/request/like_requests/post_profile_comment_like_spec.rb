require 'rails_helper'

RSpec.describe 'PostUserAdLike', type: :request do
  let(:user)            { create(:user, :with_auth_token)}

  let(:another)         { create(:user) }

  let(:heading)         { create(:heading, user: another, id: 1) }

  let(:ad)              { create(:ad, user: another, heading: heading, id: 1) }

  let(:comment)         { create(:comment, user: another, ad: ad, id: 1) }

  let(:value)           { user.auth_token.value }

  let(:params)          { { like: { kind: 0 }, user_id: user.id, comment_id: comment.id, heading_id: heading.id, ad_id: ad.id } }

  let(:resource_params) { attributes_for(:like) }

  let(:headers)         { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      'kind' => like.kind
    }
  end

  before { build(:like, resource_params.merge(user: user, likeable: comment)) }

  let(:like) { Like.last }

  context do
    before { post '/api/profile/headings/1/ads/1/comments/1/like', params: params.to_json , headers: headers }

    it('returns record') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/headings/1/ads/1/comments/1/like', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/headings/1/ads/1/comments/1/like', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
