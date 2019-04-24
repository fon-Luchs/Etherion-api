require 'rails_helper'

RSpec.describe Ad::AdFinder do
  let(:user) { create(:user) }

  let(:heading) { create(:heading, user: user, name: 'Paradigma') }

  let(:ad) { create_list(:ad, 4, heading: heading, user: user, text: "Hello #{Ad.count}") }

  let(:params) { { id: ad.first.id, heading_id: heading.id } }

  subject { Ad::AdFinder.new(params: params, current_user: user) }

  describe '#find' do
    its(:find) { should eq ad.first }
  end

  describe '#all' do
    its(:all) { should eq user.ads.where(heading_id: heading.id).order(created_at: :desc) }
  end
end
