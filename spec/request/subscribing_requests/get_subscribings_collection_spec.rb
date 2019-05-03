require 'rails_helper'

RSpec.describe 'GetSubscribingsCollection', type: :request do
  let(:another)       { create(:user) }

  let!(:user)         { create(:user, :with_auth_token)}

  let(:value)         { user.auth_token.value }

  let(:headers)       { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:subscribe)    { create(:subscriber, subscriber: another, subscribing: user) }

  let(:subscribing_collection) do
    [{
      'id' => Subscriber.last.id,
      'status' => 'subscribed',
      'user' => {
        'id' => another.id,
        'nickname' => another.nickname
      }
    }]
  end

  context do
    before { get '/api/profile/subscribings', params: {}, headers: headers }

    it('returns collection of subscribing') { expect(JSON.parse(response.body)).to eq subscribing_collection }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/subscribings', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
