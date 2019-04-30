require 'rails_helper'

RSpec.describe Subscriber::DisallowSelfReferentialSubscribeValidator do
  let(:user)    { create(:user) }

  let(:record)  { build(:subscriber, subscriber: user, subscribing: user) }

  it { expect(subject.validate(record)).to eq ['Can\'t self refer'] }
end
