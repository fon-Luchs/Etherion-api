require 'rails_helper'

RSpec.describe SubscriberDecorator do
  let(:current)   { create(:user) }

  let(:another)   { create(:user) }

  let(:subscribe) { create(:subscriber, subscriber: current, subscribing: another) }

  describe '#subscribers_index' do
    subject { subscribe.decorate(context: { subscriber_index: true }).as_json }

    its([:id])      { should eq subscribe.id }

    its([:status])  { should eq 'subscriber' }

    its([:user])    { should eq user another }
  end

  describe '#subscribings_index' do
    subject { subscribe.decorate(context: { subscribing_index: true }).as_json }

    its([:id])      { should eq subscribe.id }

    its([:status])  { should eq 'subscribed' }

    its([:user])    { should eq user current }
  end

  describe '#subscribings_create' do
    subject { subscribe.decorate(context: { subscribing_create: true }).as_json }

    its([:id])      { should eq subscribe.id }

    its([:status])  { should eq 'subscribed' }

    its([:user])    { should eq show_user current }
  end

  def user(user)
    {
      id: user.id,
      nickname: user.nickname
    }
  end

  def show_user(user)
    {
      id: user.id,
      nickname: user.nickname,
      login: user.login,
      headings: user.headings.decorate.as_json,
      subscribers: [{id: subscribe.id, status: 'subscriber', user: { id: another.id, nickname: 'Walar Morgulis' } }],
      commune: ''
    }
  end
end
