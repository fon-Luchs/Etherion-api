require 'rails_helper'

RSpec.describe Commune::CommuneQuantityValidator do
  let(:user) { create(:user) }

  let(:commune) { create(:commune, creator: user) }

  let(:record)  { build(:commune, creator: user) }

  before { user.commune = commune }

  it { expect(subject.validate(record)).to eq ["Number of communes exceeded"] }
end
