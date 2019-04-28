require 'rails_helper'

RSpec.describe LikeDecorator do
  describe 'profile#as_json' do
    let(:user)    { create(:user) }

    let(:another) { create(:user) }

    let(:heading) { create(:heading, user: user, name: 'commune') }

    let(:ad)      { create(:ad, heading: heading, user: user) }

    let(:like)    { create(:like, likeable: ad, user: another) }

    subject       { like.decorate.as_json }

    its([:kind]) { should eq 'positive' }
  end
end
