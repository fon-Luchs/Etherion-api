require 'rails_helper'

RSpec.describe Api::LikesController, type: :controller do
  describe 'routes test' do
    it do
      should route(:post, 'api/profile/headings/1/ads/1/comments/1/like')
        .to(action: :create, controller: 'api/likes', heading_id: 1, ad_id: 1, comment_id: 1)
    end

    it do
      should route(:post, 'api/users/1/headings/1/ads/1/comments/1/like')
        .to(action: :create, controller: 'api/likes', heading_id: 1, ad_id: 1, comment_id: 1, user_id: 1)
    end

    it do
      should route(:post, 'api/users/1/headings/1/ads/1/like')
        .to(action: :create, controller: 'api/likes', heading_id: 1, ad_id: 1, user_id: 1)
    end
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:another) { create(:user) }

  let(:heading) { create(:heading, user: another, name: 'Анегдотный') }

  let(:ad)      { create(:ad, text: 'My Simple ad', user: another, heading: heading) }

  let(:answer)  { create(:comment, user: another, ad: ad, parent_id: comment.id) }

  let(:value)   { user.auth_token.value }

  let(:like)    { create(:like, likeable: ad, user: user) }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      like: { kind: 1 },
      ad_id: ad.id,
      heading_id: heading.id,
      user_id: another.id
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :like }

  describe '#create.json' do
    before do
      expect(Like::LikeBuilder).to receive_message_chain(:new, :build)
        .with(params: params, current_user: user)
        .with(no_args)
        .and_return(like)
    end

    context 'success' do
      before { expect(like).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(like).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end
end
