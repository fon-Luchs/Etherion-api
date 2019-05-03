require 'rails_helper'

RSpec.describe 'GetUSerSubscribersCollection', type: :request do
  let(:users)         { create_list(:user, 3) }

  let!(:user)         { create(:user, :with_auth_token, id: 1)}

  let(:value)         { user.auth_token.value }

  let(:headers)       { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  before { users.each { |u| create(:subscriber, subscriber: user, subscribing: u) } }

  let(:subscribers_collection) do
    Subscribe::UserSubscribers.find(user).map do |s|
      {
        'id' => Subscriber.find_by!(subscriber: user, subscribing: s).id,
        'status' => 'subscriber',
        'user' => {
          'id' => s.id,
          'nickname' => s.nickname
        }
      }
    end
  end

  context do
    before { get '/api/users/1/subscribers', params: {}, headers: headers }

    it('returns collection of subscribers') { expect(JSON.parse(response.body)).to eq subscribers_collection }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1/subscribers', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
