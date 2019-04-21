require 'rails_helper'

RSpec.describe UserObserver, type: :observer do
  subject { described_class.send(:new) }

  let(:user) { create(:user) }

  describe '#after_create' do
    before { expect(user).to receive_message_chain(:headings, :create).with(name: 'Основная').and_return(true) }

    it { expect { subject.after_create(user) }.to_not raise_error }
  end

  describe 'headings_exist?' do
    before { subject.after_create(user) }

    it { expect(user.headings.last).to eq(Heading.last) }
  end
end
