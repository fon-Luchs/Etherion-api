require 'rails_helper'

RSpec.describe Heading::HeadingBuilder do
  let(:params)         { { comment: { text: 'Paradigma' }, ad_id: ad.id } }

  let(:request_params) { ActionController::Parameters.new(params) }

  let(:heading) { create(:heading, user: user) }

  let(:user)    { create(:user) }

  let(:ad)      { create(:ad, user: user, heading: heading) }

  subject { Comment::CommentBuilder.new params: request_params, current_user: user }

  describe '#build' do
    let(:comment_builder) { subject.build }

    it { expect(comment_builder.class.name).to eq('Comment') }
  end
end
