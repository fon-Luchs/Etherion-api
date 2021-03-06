require 'rails_helper'

RSpec.describe HeadingDecorator do
  describe 'profile#as_json' do
    let(:user) { create(:user) }

    let(:heading) { create(:heading, user: user, name: 'commune') }

    before { create_list(:ad, 28, user: user, heading: heading) }

    subject { heading.decorate.as_json }

    its([:id])     { should eq heading.id }

    its([:name])   { should eq 'commune' }

    its([:author]) { should eq author }

    its([:ads])    { should eq heading.ads.decorate.as_json }
  end

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end
end
