require 'rails_helper'

RSpec.describe CommuneUser::CommuneUsersQuantityValidator do
  let(:user)    { create(:user) }

  let(:another) { create(:user) }

  let(:users)   { create_list(:user, 49) }

  let(:commune) { create(:commune, creator: user) }

  before { users.each { |u| commune.users << u } }

  let(:record) { build(:commune_user, user: another, commune: commune) }

  it { expect(subject.validate(record)).to eq ['Number of users exceeded'] }
end
