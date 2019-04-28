require 'rails_helper'

RSpec.describe Like::LikeBuilder do
  let(:params)           { { like: { kind: 0 }, ad_id: ad.id } }

  let(:request_params)   { ActionController::Parameters.new(params) }

  let(:another_user)     { create(:user) }

  let(:user)    { create(:user) }

  let(:heading) { create(:heading, user: user) }

  let(:ad)      { create(:ad, heading: heading, user: user) }

  subject { Like::LikeBuilder.new params: request_params, current_user: another_user }

  describe '#build' do
    let(:like) { subject.build }

    it { expect(like.class.name).to eq('Like') }
  end

  describe '#valid?' do
    subject { Like::LikeBuilder.new params: request_params, current_user: user }

    it { expect(subject.build.save).to eq false }
  end
end
