require 'rails_helper'

RSpec.describe Api::SubscribingsController, type: :controller do
  let(:user)      { create(:user, :with_auth_token, id: 1) }

  let(:another)   { create(:user, id: 2) }

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

  let(:params) { { user_id: another.id, subscriber: { subscriber: another } } }

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :subscriber }

  let(:subscribe) { create(:subscriber, subscriber: another, subscribing: user) }

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:subscribings, :new)
        .with(no_args)
        .with(permitted_params)
        .and_return(subscribe)
    end

    context 'success' do
      before { expect(subscribe).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(subscribe).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#index.json' do
    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
    it { should route(:get, '/api/profile/subscribings').to(action: :index, controller: 'api/subscribings') }

    it { should route(:post, '/api/users/1/subscribings').to(action: :create, controller: 'api/subscribings', user_id: 1) }
  end
end
