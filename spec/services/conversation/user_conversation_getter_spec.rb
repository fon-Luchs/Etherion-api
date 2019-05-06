require 'rails_helper'

RSpec.describe Conversation::UserConversationGetter do
  let(:current_user) { create(:user) }

  let(:other_user)   { create(:user) }

  let(:recipient)    { create(:user) }

  let(:current_conversation) { create(:conversation, sender: current_user, recipient: recipient) }

  let(:other_conversation)   { create(:conversation, sender: other_user, recipient: recipient) }

  describe '#get_conversation' do
    it { expect(subject.get_conversation(current_user, current_conversation.id)).to eq(current_conversation) }
  end

  describe '#get_conversation with error' do
    it { expect { subject.get_conversation(current_user, other_conversation.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
