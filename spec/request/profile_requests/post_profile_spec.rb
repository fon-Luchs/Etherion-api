require 'rails_helper'

RSpec.describe 'PostProfile', type: :request do

  let(:headers) { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { user: resource_params } }

  let(:resource_params) { attributes_for(:user) }

  let(:heading) do
    [
      'ads' => [],
      'author' => {
        'id' => user.id,
        'nickname' => user.nickname
      },
      'id' => user.headings.first.id,
      'name' => user.headings.first.name
    ]
  end

  let(:resource_response) do
    {
      "id" => user.id,
      "nickname" => user.nickname,
      "login" => user.login,
      "email" => user.email,
      'headings' => heading,
      'commune' => '',
      'polit_power' => user.polit_power,
      'subscribers' => [],
      'subscribings' => []
    }
  end

  before { build(:user, resource_params) }

  let(:user) { User.last }

  context do
    before { post '/api/profile', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid params' do
    before { post '/api/profile/', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
