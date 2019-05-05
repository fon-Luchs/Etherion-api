require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  it { should belong_to(:room) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:room) }

  it { should validate_presence_of(:user) }
end
