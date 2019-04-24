require 'rails_helper'

RSpec.describe Heading, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:ads).dependent(:destroy) }

  it { should allow_value('Base').for(:name) }

  it { should validate_length_of(:name).is_at_least(3).is_at_most(15) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:user) }

  context 'Heading quantity limit' do
    let(:user) { create(:user) }

    before { create_list(:heading, 14, user: user, name: 'normal') }

    it { expect { user.headings.create! name: 'FATAL' }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
