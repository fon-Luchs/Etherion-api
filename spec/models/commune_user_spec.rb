require 'rails_helper'

RSpec.describe CommuneUser, type: :model do
  it { should belong_to(:user) }

  it { should belong_to(:commune) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:commune) }

  context 'Commune users quantity limit' do
    let(:user)    { create(:user) }

    let(:another) { create(:user) }

    let(:users)   { create_list(:user, 49) }

    let(:commune) { create(:commune, creator: user) }

    before { users.each { |u| commune.users << u } }

    it { expect { commune.users << another }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
