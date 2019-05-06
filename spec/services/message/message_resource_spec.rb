require 'rails_helper'

RSpec.describe Message::MessageResource do
  let(:user)     { create(:user) }

  let(:commune)  { create(:commune, creator: user) }

  let(:room)     { create(:room, commune: commune) }

  let!(:message) { create(:message, user: user, messageable: room) }

  describe '#call' do
    it { expect(subject.call(user, room)).to eq message }
  end
end
