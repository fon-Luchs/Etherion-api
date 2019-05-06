
require 'rails_helper'

RSpec.describe Message::MessageParent do
  let(:user) { create(:user) }

  let(:recipient) { create(:user) }

  describe '#call for room' do
    let(:commune) { create(:commune, creator: user) }

    let(:room)    { create(:room, commune: commune) }

    let(:params)  { { room_id: room.id } }

    it { expect(subject.call(params)).to eq room }
  end

  describe '#call for conversation' do
    let(:conversation) { create(:conversation, sender: user, recipient: recipient) }

    let(:params) { { conversation_id: conversation.id } }

    it { expect(subject.call(params)).to eq conversation }
  end
end
