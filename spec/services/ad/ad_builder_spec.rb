require 'rails_helper'

RSpec.describe Ad::AdBuilder do
  let(:params)         { { ad: { text: 'Paradigma' }, heading_id: heading.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  let(:heading) { create(:heading, user: user, name: 'Paradigma') }

  let(:user) { create(:user) }

  subject { Ad::AdBuilder.new params: request_params, current_user: user }

  describe '#build' do
    let(:ad) { subject.build }

    it { expect(ad.class.name).to eq('Ad') }
  end
end
