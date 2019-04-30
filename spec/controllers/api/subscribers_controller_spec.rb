require 'rails_helper'

RSpec.describe Api::SubscribersController, type: :controller do
  let(:user)      { create(:user, :with_auth_token, id: 1) }

  let(:another)   { create(:user) }

  let(:subscribe) { create(:subscriber, subscriber: user, subscribing: another) }

  let(:value) { user.auth_token.value }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  before { merge_headers headers }

  describe '#index.json' do
    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
    it { should route(:get, '/api/profile/subscribers').to(action: :index, controller: 'api/subscribers') }

    it { should route(:get, '/api/users/1/subscribers').to(action: :index, controller: 'api/subscribers', user_id: 1) }
  end
end
