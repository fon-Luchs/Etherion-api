require 'rails_helper'

RSpec.describe AdDecorator do
  describe 'profile#as_json' do
    let(:user)    { create(:user) }

    let(:heading) { create(:heading, user: user, name: 'commune') }

    let(:ad) { create(:ad, heading: heading, user: user) }

    let!(:comments) { create_list(:comment, 1, user: user, ad: ad) }

    subject    { ad.decorate.as_json }

    its([:id]) { should eq ad.id }

    its([:text])      { should eq ad.text }

    its([:author])    { should eq author }

    its([:comments])  { should eq comment }
  end

  def comment
    [
      {
        ad: { id: ad.id },
        author: author,
        id: comments.first.id,
        parent_id: comments.first.parent_id,
        text: comments.first.text,
        answers: []
      }
    ]
  end

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end
end
