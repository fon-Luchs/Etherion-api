require 'rails_helper'

RSpec.describe LikeObserver, type: :observer do
  subject       { described_class.send(:new) }

  let(:user)    { create(:user) }

  let(:heading) { create(:heading, user: user) }

  let(:ad)      { create(:ad, heading: heading, user: user) }

  let(:another) { create(:user) }

  let(:like)    { create(:like, likeable: ad, user: another) }

  let(:coef)    { 1 }

  describe '#after_create' do
    before { expect(user).to receive(:increment!).with(:polit_power, coef).and_return(true).twice }

    before { expect(ad).to receive(:increment!).with(:rate, coef).and_return(true).twice }

    it { expect { subject.after_create(like) }.to_not raise_error }
  end

  describe '#after_destroy' do
    before { expect(user).to receive(:decrement!).with(:polit_power, coef).and_return(true) }

    before { expect(ad).to receive(:decrement!).with(:rate, coef).and_return(true) }

    it { expect { subject.after_destroy(like) }.to_not raise_error }
  end
end
