require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to :user }

  it { should belong_to :likeable }

  it { should define_enum_for :kind }

  describe 'uniquness_of_user_likes' do
    let(:current_user) { create(:user) }

    let(:another_user) { create(:user) }

    let(:heading)      { create(:heading, user: another_user) }

    let(:ad)           { create(:ad, heading: heading, user: another_user) }

    before { current_user.likes.create! likeable: ad }

    it { expect { current_user.likes.create! likeable: ad }.to raise_error(ActiveRecord::RecordInvalid) }
  end

  context 'self_like_validator' do
    let(:current_user) { create(:user) }

    let(:heading)      { create(:heading, user: current_user) }

    let(:ad)           { create(:ad, heading: heading, user: current_user) }

    it { expect { current_user.likes.create! likeable: ad, kind: 1 }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
