require 'rails_helper'

RSpec.describe 'PostConversation', type: :request do
  let(:user)      { create(:user, :with_auth_token) }

  let(:recipient) { create(:user, id: 1, nickname: 'Zibroff') }

  let(:value)   { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params)  { { user_id: recipient.id } }

  let(:resource_response) do
    {
      'id' => conversation.id,
      'messages' => [],
      'nickname' => recipient.nickname
    }
  end

  before { build(:conversation, sender: user, recipient: recipient) }

  let(:conversation) { Conversation.last }

  context do
    before { post '/api/users/1/conversations', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/conversations', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
