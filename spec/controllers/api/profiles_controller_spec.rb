require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  subject(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:nickname) { FFaker::Internet.user_name + 'asd' }

  let(:login)    { '@' + FFaker::InternetSE.login_user_name }

  let(:email)    { FFaker::Internet.email }

  let(:password) { FFaker::Internet.password }

  let(:params) do
    {
      user: {
        login: login,
        nickname: nickname,
        email: email,
        password: password,
        password_confirmation: password,
      }
    }
  end

  before { sign_in user }

  let(:permited_params) { permit_params! params, :user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
    before { build_resource }

    context 'success' do
      before { expect(user).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(user).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    context 'success' do
      before { expect(user).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(user).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_headers headers }

    before { get :show, format: :json }

    it { should render_template :show }
  end

  describe '#destroy' do
    before { merge_headers headers }

    before { delete :destroy, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe 'routes test' do
    it { should route(:get, '/api/profile').to(action: :show, controller: 'api/profiles') }

    it { should route(:post, '/api/profile').to(action: :create, controller: 'api/profiles') }

    it { should route(:put, '/api/profile').to(action: :update, controller: 'api/profiles') }

    it { should route(:delete, '/api/profile').to(action: :destroy, controller: 'api/profiles') }
  end

  def build_resource
    expect(User).to receive(:new).with(permited_params).and_return(user)
  end
end
