require 'rails_helper'

RSpec.describe 'PatchAd', type: :request do
  let(:user)    { create(:user, :with_auth_token)}

  let(:heading) { create(:heading, user: user, id: 1, name: 'новая') }

  let!(:ad)     { create(:ad, user: user, heading: heading, id: 1) }

  let(:value)   { user.auth_token.value }

  let(:params)  { { ad: { text: 'другая' } } }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:author)  { { 'id' => user.id, 'nickname' => user.nickname } }

  let!(:comment){ create(:comment, ad: ad, user: user) }

  let!(:answer) { create(:comment, ad: ad, user: user, parent_id: comment.id) }

  let(:comment_response) do
    {
      'ad' => { 'id' => ad.id },
      'author' => author,
      'id' => comment.id,
      'parent_id' => comment.parent_id,
      'text' => comment.text,
      'answers' => [{
        'ad' => { 'id' => ad.id },
        'author' => author,
        'id' => answer.id,
        'parent_id' => answer.parent_id,
        'text' => answer.text,
        'answers' => []
      }]
    }
  end

  let(:resource_response) do
    {
      'id' => ad.id,
      'author' => author,
      'text' => Ad.last.text,
      'heading' => { 'id' => heading.id, 'name' => heading.name },
      'comments' => [comment_response]
    }
  end

  context do
    before { patch '/api/profile/headings/1/ads/1', params: params.to_json , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { patch '/api/profile/headings/1/ads/1', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'Record was not found' do
    before { patch '/api/profile/headings/0/ads/1', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'Record was not found' do
    before { patch '/api/profile/headings/1/ads/0', params: params.to_json , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end

  context 'invalid params' do
    before { patch '/api/profile/headings/1/ads/1', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
