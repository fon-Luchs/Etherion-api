require 'rails_helper'

RSpec.describe Api::RoomUsersController, type: :controller do
  describe 'routes test' do
    it do
      should route(:post, 'api/profile/communes/1/rooms/1/join')
        .to(action: :create, controller: 'api/room_users', commune_id: 1, room_id: 1)
    end

    it do
      should route(:delete, 'api/profile/communes/1/rooms/1/leave')
        .to(action: :destroy, controller: 'api/room_users', commune_id: 1, room_id: 1)
    end

    it do
      should route(:post, 'api/users/1/communes/1/rooms/1/join')
        .to(action: :create, controller: 'api/room_users', commune_id: 1, room_id: 1, user_id: 1)
    end

    it do
      should route(:delete, 'api/users/1/communes/1/rooms/1/leave')
        .to(action: :destroy, controller: 'api/room_users', commune_id: 1, room_id: 1, user_id: 1)
    end
  end

  let(:user)      { create(:user, :with_auth_token) }

  let(:commune)   { create(:commune, creator: user, id: 1) }

  let(:room)      { create(:room, commune: commune, id: 1) }

  let(:room_user) { create(:room_user, room: room, user: user) }

  let(:value)     { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params)           { { commune_id: commune.id, room_id: room.id } }

  before                 { sign_in user }

  describe '#create.json' do
    before do
      expect(Room::RoomUsers::RoomUserBuilder).to receive_message_chain(:new, :build)
        .with(params: params, current_user: user)
        .with(no_args)
        .and_return(room_user)
    end

    context 'success' do
      before { expect(room_user).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(room_user).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end

  describe '#destroy.json' do
    before do
      expect(Room::RoomUsers::RoomUserFinder).to receive_message_chain(:new, :find)
        .with(params: params, current_user: user)
        .with(no_args)
        .and_return(room_user)
    end

    before { merge_headers headers }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
