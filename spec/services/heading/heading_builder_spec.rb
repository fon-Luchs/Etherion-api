require 'rails_helper'

RSpec.describe Heading::HeadingBuilder do
  let(:params) { { heading: { name: 'Paradigma' } } }

  let(:permitted_params) { permit_params! params, :heading }

  let(:user) { create(:user) }

  subject { Heading::HeadingBuilder.new permitted_params: permitted_params, current_user: user }

  describe '#build' do
    let(:heading) { subject.build }

    it { expect(heading.class.name).to eq('Heading') }
  end

  describe '#valid?' do
    before { create_list(:heading, 14, user: user, name: 'simple') }

    it { expect(subject.build.save).to eq false }
  end
end
