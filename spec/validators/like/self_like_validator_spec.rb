require 'rails_helper'

RSpec.describe Like::SelfLikeValidator do
  let(:user)    { create(:user) }

  let(:heading) { create(:heading, user: user) }

  let(:ad)      { create(:ad, user: user, heading: heading) }

  let(:record)  { build(:like, user: user, likeable: ad) }

  it { expect(subject.validate(record)).to eq ['Can\'t take like to myself records'] }
end
