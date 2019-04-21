require 'rails_helper'

RSpec.describe Heading::HeadingFinder do
  let(:user) { create(:user) }

  let(:heading) { create(:heading, user: user, name: 'Kuznya') }

  describe 'prifule#find' do
    let(:params) { { id: heading.id } }

    subject { Heading::HeadingFinder.new(params, user) }

    its(:find) { should eq heading }
  end

  describe 'user#find' do
    let(:params) { { id: heading.id, user_id: user.id } }

    subject { Heading::HeadingFinder.new(params, user) }

    its(:find) { should eq heading }
  end
end
