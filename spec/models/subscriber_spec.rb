require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  it { should belong_to(:subscriber) }

  it { should belong_to(:subscribing) }

  it { should validate_presence_of(:subscriber) }

  it { should validate_presence_of(:subscribing) }

  context 'self_refer_validator' do
    let(:current_user) { create(:user) }

    it { expect { current_user.subscribings.create! subscriber: current_user }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
