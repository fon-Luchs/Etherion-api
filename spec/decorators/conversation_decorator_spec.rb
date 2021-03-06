require 'rails_helper'

RSpec.describe ConversationDecorator do
  let(:sender)        { create(:user) }

  let(:recipient)     { create(:user) }

  let(:conversations) { create(:conversation, sender: sender, recipient: recipient) }

  # let(:message) { create(:message, messageable_type: conversations.class.name, messageable_id: conversations.id, user_id: sender.id, text: 'LOL') }

  # let(:decorated_message) { message.decorate.as_json }

  describe 'show#json' do
    subject          { conversations.decorate(context: {user_id: sender.id}).as_json }

    its([:id])       { should eq conversations.id }

    its([:nickname]) { should eq recipient.nickname }

    its([:messages]) { should eq [] }
  end

  describe 'index#json' do
    subject          { conversations.decorate(context: {conversations_index: true}).as_json }

    its([:id])       { should eq conversations.id }

    its([:nickname]) { should eq recipient.nickname }
  end
end
