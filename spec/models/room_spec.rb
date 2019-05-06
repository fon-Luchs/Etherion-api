require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_many(:messages) }

  it { should belong_to(:commune) }

  it { should allow_value('Base').for(:name) }

  it { should validate_length_of(:name).is_at_least(3).is_at_most(15) }

  it { should validate_presence_of(:name) }
end
