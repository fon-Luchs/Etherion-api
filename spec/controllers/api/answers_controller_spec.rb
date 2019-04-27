require 'rails_helper'

RSpec.describe Api::AnswersController, type: :controller do
  describe 'routes test' do
    it do
      should route(:post, 'api/profile/headings/1/ads/1/comments/1/answers')
        .to(action: :create, controller: 'api/answers', heading_id: 1, ad_id: 1, comment_id: 1)
    end

    it do
      should route(:post, 'api/users/1/headings/1/ads/1/comments/1/answers')
        .to(action: :create, controller: 'api/answers', heading_id: 1, ad_id: 1, comment_id: 1, user_id: 1)
    end
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:heading) { create(:heading, user: user, name: 'Анегдотный') }

  let(:ad)      { create(:ad, text: 'My Simple ad', user: user, heading: heading) }

  let(:comment) { create(:comment, user: user, ad: ad) }

  let(:answer)  { create(:comment, user: user, ad: ad, parent_id: comment.id) }

  let(:value)   { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      comment: { text: 'My Simple ad' },
      ad_id: ad.id,
      heading_id: heading.id,
      comment_id: comment.id
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :comment }

  describe '#create.json' do
    before do
      expect(Comment::CommentBuilder).to receive_message_chain(:new, :build)
        .with(params: params, current_user: user)
        .with(no_args)
        .and_return(answer)
    end

    context 'success' do
      before { expect(answer).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(answer).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end
end
