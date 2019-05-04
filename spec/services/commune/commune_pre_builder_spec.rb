require 'rails_helper'

RSpec.describe Commune::CommunePreBuilder do
  let(:user) { create(:user) }

  subject    { Commune::CommunePreBuilder }

  describe 'valid#pre_build' do
    let(:another) { create(:user) }

    let(:commune) { create(:commune, creator: another) }

    let(:record)  { build(:commune, creator: user) }

    let!(:join)   { create(:commune_user, user: user, commune: commune) }

    it { expect(subject.build(record)).to eq join }
  end

  describe 'without_joins#pre_build' do
    let(:another) { create(:user) }

    let(:record)  { build(:commune, creator: user) }

    it { expect(subject.build(record)).to eq nil }
  end

  describe 'invalid#pre_build' do
    let(:commune) { create(:commune, creator: user) }

    let(:record)  { build(:commune, creator: user) }

    let!(:join)   { create(:commune_user, user: user, commune: commune) }

    before { user.commune = commune }

    it { expect(subject.build(record)).to eq nil }
  end
end
