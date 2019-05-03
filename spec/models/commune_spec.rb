require 'rails_helper'

RSpec.describe Commune, type: :model do
  it { should belong_to(:creator) }

  it { should have_many(:commune_users) }

  it { should have_many(:users).through(:commune_users).source(:user) }

  it { should validate_presence_of(:creator) }

  it { should allow_value('Base').for(:name) }

  it { should validate_length_of(:name).is_at_least(3).is_at_most(15) }

  it { should validate_presence_of(:name) }

  context 'Communes quantity limit' do
    let(:user) { create(:user) }

    let(:commune) { create(:commune, creator: user) }

    before { user.commune = commune }

    it { expect { create(:commune, creator: user) }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
