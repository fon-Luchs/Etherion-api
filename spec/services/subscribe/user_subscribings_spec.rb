require 'rails_helper'

RSpec.describe Subscribe::UserSubscribings do
  let(:current_user) { create(:user, nickname: 'OWNER') }

  let(:user)         { create(:user, nickname: 'SUBSCRIBER') }

  let!(:subscriber)  { create(:subscriber, subscriber: current_user, subscribing: user) }

  it { expect(subject.find(user)).to eq([current_user]) }
end
