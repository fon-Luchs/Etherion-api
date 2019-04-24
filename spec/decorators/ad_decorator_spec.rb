require 'rails_helper'

RSpec.describe AdDecorator do
  describe 'profile#as_json' do
    let(:user) { create(:user) }

    let(:heading) { create(:heading, user: user, name: 'commune') }

    let(:ad) { create(:ad, heading: heading, user: user) }

    subject { ad.decorate.as_json }

    its([:id]) { should eq ad.id }

    its([:text]) { should eq ad.text }

    its([:author]) { should eq author }
  end

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end
end
