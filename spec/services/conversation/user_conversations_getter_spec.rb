require 'rails_helper'

RSpec.describe Conversation::UserConversationsGetter do
  let(:current_user) { create(:user) }

  let(:other_user)   { create(:user) }

  let(:recipient)    { create(:user) }

  let(:current_conversation) { create(:conversation, sender: current_user, recipient: recipient) }

  let(:other_conversation)   { create(:conversation, sender: other_user, recipient: recipient) }

  describe '#get_conversations' do
    it { expect(subject.get_conversations(current_user)).to eq([current_conversation]) }
  end
end
