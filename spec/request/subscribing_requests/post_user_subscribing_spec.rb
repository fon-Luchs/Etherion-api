require 'rails_helper'

RSpec.describe 'PostSubscribingsCollection', type: :request do
  let(:another)       { create(:user, id: 1) }

  let!(:user)         { create(:user, :with_auth_token)}

  let(:value)         { user.auth_token.value }

  let(:headers)       { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params)        { { user_id: another.id, subscriber: { subscriber: another } } }

  let(:heading) do
    [
      'ads'    => [],
      'author' => {
        'id'       => another.id,
        'nickname' => another.nickname
      },
      'id'   => another.headings.first.id,
      'name' => another.headings.first.name
    ]
  end

  let(:subscribers) do
    Subscribe::UserSubscribers.find(another).map do |s|
      {
        'id' => Subscriber.find_by!(subscriber: another, subscribing: s).id,
        'status' => 'subscriber',
        'user' => {
          'id' => s.id,
          'nickname' => s.nickname
        }
      }
    end
  end

  let(:resource_response) do
    {
      'id' => subscribe.id,
      'status' => 'subscribed',
      'user' => {
        'id' => another.id,
        'nickname'  => another.nickname,
        'commune'   => '',
        'login'     => another.login,
        'headings'  => heading,
        'subscribers' => subscribers
      }
    }
  end

  before          { build(:subscriber, subscriber: another, subscribing: user) }

  let(:subscribe) { Subscriber.last }

  context do
    before { post '/api/users/1/subscribings', params: params.to_json, headers: headers }

    it('returns collection of subscribings') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/subscribings', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
