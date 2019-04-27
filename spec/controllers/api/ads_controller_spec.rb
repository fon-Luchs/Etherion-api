require 'rails_helper'

RSpec.describe Api::AdsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/profile/headings/1/ads').to(action: :create, controller: 'api/ads', heading_id: 1) }

    it { should route(:patch, 'api/profile/headings/1/ads/1').to(action: :update, controller: 'api/ads', heading_id: 1, id: 1) }

    it { should route(:get, 'api/profile/headings/1/ads/1').to(action: :show, controller: 'api/ads',  heading_id: 1, id: 1) }

    it { should route(:delete, 'api/profile/headings/1/ads/1').to(action: :destroy, controller: 'api/ads', heading_id: 1, id: 1) }

    it { should route(:get, 'api/users/1/headings/1/ads/1').to(action: :show, controller: 'api/ads', heading_id: 1, user_id: 1, id: 1) }
  end

  let(:user) { create(:user, :with_auth_token) }

  let(:heading) { create(:heading, user: user, name: 'Анегдотный') }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      ad: { text: 'My Simple ad' },
      heading_id: heading.id
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :ad }

  let(:ad) { create(:ad, text: 'My Simple ad', user: user, heading: heading) }

  describe '#create.json' do

    before do
      expect(Ad::AdBuilder).to receive_message_chain(:new, :build)
        .with(params: params, current_user: user)
        .with(no_args)
        .and_return(ad)
    end

    context 'success' do
      before { expect(ad).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(ad).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:params) do
      {
        ad: { text: 'колектнадзор' },
        heading_id: heading.id,
        id: ad.id
      }
    end

    before { expect(subject).to receive(:resource).and_return(heading) }

    context 'success' do
      before { expect(heading).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(heading).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'profile#show.json' do
    let(:params) { { heading_id: heading.id, id: ad.id } }

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe 'user#show.json' do
    let(:params) { { heading_id: heading.id, user_id: user.id, id: ad.id } }

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#destroy.json' do
    let(:params) { { id: ad.id, heading_id: heading.id } }

    before { merge_headers headers }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
