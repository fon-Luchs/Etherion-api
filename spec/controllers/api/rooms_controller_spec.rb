require 'rails_helper'

RSpec.describe Api::RoomsController, type: :controller do
  describe 'routes test' do
    it do
      should route(:post, 'api/profile/communes/1/rooms').to(action: :create, controller: 'api/rooms', commune_id: 1)
    end

    it do
      should route(:get, 'api/profile/communes/1/rooms/1').to(action: :show, controller: 'api/rooms', id: 1, commune_id: 1)
    end

    it do
      should route(:patch, 'api/profile/communes/1/rooms/1').to(action: :update, controller: 'api/rooms', id: 1, commune_id: 1)
    end

    it do
      should route(:get, 'api/users/1/communes/1/rooms/1').to(action: :show, controller: 'api/rooms', user_id: 1, id: 1, commune_id: 1)
    end

    it do
      should route(:delete, 'api/profile/communes/1/rooms/1').to(action: :destroy, controller: 'api/rooms', id: 1, commune_id: 1)
    end
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:commune) { create(:commune, creator: user, id: 1) }

  let(:room)    { create(:room, commune: commune) }

  let(:value)   { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params)           { { room: { name: room.name.to_s }, commune_id: commune.id } }

  let(:permitted_params) { permit_params! params, :room }

  before                 { sign_in user }

  describe '#create.json' do
    before do
      expect(Room::RoomBuilder).to receive_message_chain(:new, :build)
        .with(params: params)
        .with(no_args)
        .and_return(room)
    end

    context 'success' do
      before { expect(room).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(room).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_headers headers }

    before { get :show, params: { commune_id: commune.id.to_s, id: room.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe '#update.json' do
    let(:params) { { room: { name: 'Waaagh' }, commune_id: commune.id, id: room.id } }

    before do
      expect(Room::RoomFinder).to receive_message_chain(:new, :find)
        .with(params: params)
        .with(no_args)
        .and_return(room)
    end

    context 'success' do
      before { expect(room).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(room).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#destroy.json' do
    before { merge_headers headers }

    before { delete :destroy, params: { commune_id: commune.id.to_s, id: room.id.to_s }, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
