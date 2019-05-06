require 'rails_helper'

RSpec.describe Room::RoomUsers::RoomUserBuilder do
  let(:user)    { create(:user) }

  let(:another) { create :user }

  let(:params)  { { recipient_id: another.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  subject { Conversation::ConversationBuilder.new params: request_params, current_user: user }

  describe '#builde.json' do
    let(:build) { subject.build }

    it { expect(build.class.name).to eq 'Conversation' }
  end
end
