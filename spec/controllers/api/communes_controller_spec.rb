require 'rails_helper'

RSpec.describe Api::CommunesController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/profile/communes').to(action: :create, controller: 'api/communes') }

    it { should route(:get, 'api/profile/communes/1').to(action: :show, controller: 'api/communes', id: 1) }

    it { should route(:patch, 'api/profile/communes/1').to(action: :update, controller: 'api/communes', id: 1) }

    it { should route(:get, 'api/users/1/communes/1').to(action: :show, controller: 'api/communes', id: 1, user_id: 1) }
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:commune) { create(:commune, creator: user) }

  let(:value)   { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      commune:
      {
        name: commune.name,
        creator: user
      }
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :commune }

  describe '#create.json' do
    before { expect(Commune).to receive(:new).with(permitted_params).and_return(commune) }

    context 'success' do
      before { expect(commune).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(commune).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:params) do
      {
        id: commune.id
      }
    end

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#update.json' do
    let(:params) do
      {
        commune: { name: commune.name },
        id: commune.id
      }
    end

    before { expect(commune).to receive_message_chain(:creator, :==).and_return(true) }

    before { expect(Commune).to receive(:find).with(commune.id.to_s).and_return(commune) }

    context 'success' do
      before { expect(commune).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(commune).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#destroy' do
    before { merge_headers headers }

    before { delete :destroy, params: {id: commune.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
