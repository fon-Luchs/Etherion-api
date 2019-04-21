require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should have_one(:auth_token).dependent(:destroy) }

  it { should have_many(:headings).dependent(:destroy) }

  it { should allow_value('example@tst.com').for(:email) }

  it { should validate_presence_of(:email) }

  it { should validate_length_of(:login).is_at_least(3).is_at_most(15) }

  it { should validate_presence_of(:login) }

  it { should allow_value('@lewiy').for(:login) }

  it { should validate_length_of(:nickname).is_at_least(3).is_at_most(15) }

  it { should allow_value('lewiy').for(:nickname) }

  it { should validate_presence_of(:nickname) }

  it { should validate_length_of(:password).is_at_least(8) }

  describe 'uniqueness_case_insensitive' do
    let(:current_user) { create(:user, login: '@lewiy', email: 'lewiy@gmail.com') }

    it('should unique login') do
      expect { User.create! login: '@Lewiy' }
        .to raise_error(ActiveRecord::RecordInvalid)
    end

    it('should unique email') do
      expect { User.create! email: '@Lewiy@gmail.com' }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
