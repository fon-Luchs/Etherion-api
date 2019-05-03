require 'rails_helper'

RSpec.describe CommuneObserver, type: :observer do
  subject       { described_class.send(:new) }

  let(:user)    { create(:user) }

  describe '#after_create' do
    let(:commune)      { create(:commune, creator: user) }

    let(:commune_user) { create(:commune_user, user: user, commune: commune) }

    before do
      expect(commune).to receive_message_chain(:users, :<<)
        .with(no_args)
        .with(commune.creator)
        .and_return(commune_user)
    end

    it { expect { subject.after_create(commune) }.to_not raise_error }
  end

  describe '#before_create' do
    let(:another)      { create(:user) }

    let(:commune)      { create(:commune, creator: another) }

    let(:commune_user) { create(:commune_user, user: user, commune: commune) }

    before do
      expect(CommuneUser).to receive_message_chain(:find_by, :destroy)
        .with(user: user)
        .with(no_args)
        .and_return(commune_user)
    end

    it { expect { subject.before_create(commune) }.to_not raise_error }
  end
end
