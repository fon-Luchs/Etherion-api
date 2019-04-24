require 'rails_helper'

RSpec.describe Ad, type: :model do
  it { should belong_to(:user) }

  it { should belong_to(:heading) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:heading) }

  it { should validate_presence_of(:text) }

  it { should validate_length_of(:text).is_at_most(256) }
end
