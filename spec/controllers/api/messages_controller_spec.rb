require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do
  describe 'routes' do
    it { should route(:post, 'api/profile/conversations/1/messages').to(action: :create, controller: 'api/messages', conversation_id: 1) }

    it { should route(:patch, 'api/profile/conversations/1/messages/1').to(action: :update, controller: 'api/messages', conversation_id: 1, id: 1) }

    it do
      should route(:post, 'api/profile/communes/1/rooms/1/messages')
        .to(action: :create, controller: 'api/messages', room_id: 1, commune_id: 1)
    end

    it do
      should route(:patch, 'api/profile/communes/1/rooms/1/messages/1')
        .to(action: :update, controller: 'api/messages', room_id: 1, id: 1, commune_id: 1)
    end
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:commune) { create(:commune, creator: user, id: 1) }

  let(:room)    { create(:room, commune: commune, id: 1 ) }

  let(:message) { create(:message, user: user, messageable: room) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { message: { text: message.text, user_id: message.user.id } } }

  let(:permitted_params) { permit_params! params, :message }

  before { sign_in user }

  describe 'create#json' do
    let(:params) { { room_id: room.id, commune_id: commune.id, message: { text: message.text, user_id: message.user.id } } }

    before { expect(Room).to receive(:find).with(room.id.to_s).and_return(room) }

    before do
      expect(room).to receive_message_chain(:messages, :new)
        .with(no_args).with(permitted_params).and_return(message)
    end

    context 'success' do
      before { expect(message).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(message).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'update#json' do
    let(:params) { { id: message.id, room_id: room.id, commune_id: commune.id, message: { text: message.text, user_id: message.user.id } } }

    before do 
      expect(Message).to receive(:find_by!)
        .with(user_id: user.id, messageable_id: room.id, messageable_type: room.class.name)
        .and_return(message)
    end

    context 'success' do
      before { expect(message).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json  }

      it { should render_template :update }
    end

    context ' fail' do
      before { expect(message).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { patch :update, params: params, format: :json  }

      it { should render_template :errors }
    end
  end
end
