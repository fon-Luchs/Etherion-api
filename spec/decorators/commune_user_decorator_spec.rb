require 'rails_helper'

RSpec.describe CommuneUserDecorator do
  let(:user)     { create(:user, nickname: 'Lollita') }

  let(:commune)  { create(:commune, creator: user) }

  let(:another)  { create(:user) }

  let!(:join)    { create(:commune_user, user: another, commune: commune) }

  subject        { join.decorate.as_json }

  its([:status]) { should eq "Welcome to #{commune.name}" }

  its([:author]) { should eq author }

  its([:chats])  { should eq [] }

  its([:users])  { should eq users }

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end

  def users
    [
      {
        id: another.id,
        nickname: another.nickname
      },

      {
        id: user.id,
        nickname: user.nickname
      }
    ]
  end
end
