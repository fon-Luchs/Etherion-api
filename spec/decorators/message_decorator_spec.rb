require 'rails_helper'

RSpec.describe MessageDecorator do
  let(:user)    { create(:user, nickname: 'Ultra Lord') }

  let(:commune) { create(:commune, creator: user) }

  let(:room)    { create(:room, commune: commune) }

  let(:message) { create(:message, messageable: room, user: user, text: 'LOL') }

  describe '#as_json' do
    subject { message.decorate.as_json }

    its([:author]) { should eq( { id: user.id, nickname: 'Ultra Lord' } ) }

    its([:id])     { should eq message.id }

    its([:text])   { should eq message.text }
  end
end
