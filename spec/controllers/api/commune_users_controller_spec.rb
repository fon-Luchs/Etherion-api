require 'rails_helper'

RSpec.describe Api::CommuneUsersController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/users/1/communes/1/join').to(action: :create, controller: 'api/commune_users', user_id: 1, commune_id: 1) }

    it { should route(:delete, 'api/users/1/communes/1/leave').to(action: :destroy, controller: 'api/commune_users', user_id: 1, commune_id: 1) }
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:commune) { create(:commune, creator:user, id: 1) }

  let(:join)    { create(:commune_user, user: user, commune: commune) }

  let(:value)   { user.auth_token.value }

  let(:request_headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params)           { { commune_user: { commune: commune, user: user }, commune_id: commune.id } }

  let(:permitted_params) { permit_params! params, :commune_user }

  before                 { sign_in user }

  describe '#create#json' do
    before { expect(CommuneUser).to receive(:find_or_initialize_by).with(permitted_params).and_return(join) }

    context 'success' do
      before { expect(join).to receive(:save).and_return(true) }

      before { merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(join).to receive(:save).and_return(false) }

      before { merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end

  describe 'delete#json' do
    before { expect(CommuneUser).to receive(:find_by!).with(user: user, commune: commune).and_return(join) }

    before { merge_headers request_headers }

    before { delete :destroy, params: { commune_id: commune.id }, format: :json }

    it     { expect(response).to have_http_status(204) }
  end

end
