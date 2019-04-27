require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/profile/headings/1/ads/1/comments').to(action: :create, controller: 'api/comments', heading_id: 1, ad_id: 1) }

    it { should route(:post, 'api/users/1/headings/1/ads/1/comments').to(action: :create, controller: 'api/comments', user_id: 1, heading_id: 1, ad_id: 1) }

    it { should route(:get, 'api/profile/headings/1/ads/1/comments/1').to(action: :show, controller: 'api/comments',  heading_id: 1, ad_id: 1, id: 1) }

    it { should route(:get, 'api/users/1/headings/1/ads/1/comments/1').to(action: :show, controller: 'api/comments', ad_id: 1, heading_id: 1, user_id: 1, id: 1) }
  end

  let(:user)    { create(:user, :with_auth_token) }

  let(:heading) { create(:heading, user: user, name: 'Анегдотный') }

  let(:ad)      { create(:ad, text: 'My Simple ad', user: user, heading: heading) }

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
      heading_id: heading.id
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :comment }

  let(:comment)          { create(:comment, user: user, ad: ad) }

  describe '#create.json' do

    before { expect(user).to receive_message_chain(:comments, :new).with(permitted_params.merge(ad: ad)).and_return(comment) }

    context 'success' do

      before { expect(comment).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :create }
    end

    context 'fail' do
      before { expect(comment).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it     { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:params) do
      {
        ad_id: ad.id,
        heading_id: heading.id,
        id: comment.id
      }
    end

    before { merge_headers headers }

    before { get :show, params: params, format: :json }

    it { should render_template :show }
  end
end
