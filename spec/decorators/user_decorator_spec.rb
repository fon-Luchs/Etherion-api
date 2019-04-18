require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) do
      create(
        :user, nickname: 'Остап Вишня',
               email: 'otap123@oda.com.ua',
               login: '@osavul'
      )
    end

    subject { profile.decorate(context: {profile: true}).as_json }

    its([:nickname])   { should eq 'Остап Вишня' }

    its([:email])      { should eq 'otap123@oda.com.ua' }

    its([:login])      { should eq '@osavul' }

    its([:ads])        { should eq [] }

    its([:readers])    { should eq [] }

    its([:readables])  { should eq [] }

    its([:letters])    { should eq [] }

    its([:commune])    { should eq '' }

    its([:polit_rate]) { should eq 0 }
  end

  describe 'users#as_json' do
    let(:user) do
      create(
        :user, nickname: 'Остап Вишня',
               email: 'otap123@oda.com.ua',
               login: '@osavul'
      )
    end

    context '#show.json' do
      subject { user.decorate(context: {user_show: true}).as_json }

      its([:nickname])   { should eq 'Остап Вишня' }

      its([:email])      { should eq 'otap123@oda.com.ua' }

      its([:login])      { should eq '@osavul' }

      its([:ads])        { should eq [] }

      its([:readers])    { should eq [] }

      its([:readables])  { should eq [] }

      its([:commune])    { should eq '' }
    end

    context '#index.json' do
      subject { user.decorate(context: {user_index: true}).as_json }

      its([:nickname]) { should eq 'Остап Вишня' }
    end
  end
end
