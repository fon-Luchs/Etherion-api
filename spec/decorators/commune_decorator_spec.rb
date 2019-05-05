require 'rails_helper'

RSpec.describe CommuneDecorator do
  let(:user)     { create(:user, nickname: 'Lollita') }

  let(:commune)  { create(:commune, creator: user) }

  let!(:room)    { create(:room, commune: commune) }

  let(:another)  { create(:user) }

  let!(:join)    { create(:commune_user, user: another, commune: commune) }

  subject        { commune.decorate.as_json }

  its([:id])     { should eq commune.id }

  its([:name])   { should eq commune.name }

  its([:author]) { should eq author }

  its([:rooms])  { should eq rooms }

  its([:users])  { should eq users }

  def rooms
    commune.rooms.map do |r|
      {
        commune: { id: commune.id, name: commune.name },
        id: r.id,
        name: r.name,
        users: []
      }
    end
  end

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end

  def users
    commune.users.map do |c|
      {
        id: c.id,
        nickname: c.nickname
      }
    end
  end
end
