require 'rails_helper'

RSpec.describe Heading::HeadingQuantityValidator do
  let(:user) { create(:user) }

  before { create_list(:heading, 14, user: user, name: 'Base') }

  let(:record) { build(:heading, user: user, name: 'Failure Heading') }

  it { expect(subject.validate(record)).to eq ['Number of headers exceeded'] }
end
