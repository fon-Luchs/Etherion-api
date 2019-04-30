require 'rails_helper'

RSpec.describe Subscribe::UserSubscribers do
  let(:current_user) { create(:user, nickname: 'OWNER') }

  let(:user)         { create(:user, nickname: 'SUBSCRIBER') }

  let!(:subscriber)  { create(:subscriber, subscriber: current_user, subscribing: user) }

  it { expect(subject.find(current_user)).to eq([user]) }
end
