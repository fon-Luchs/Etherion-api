require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }

  it { should belong_to(:ad) }

  it { should have_many(:likes).dependent(:destroy) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:text) }

  it { should validate_length_of(:text).is_at_most(128) }
end
