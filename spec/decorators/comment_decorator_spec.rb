require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:user)    { create(:user) }

  let(:heading) { create(:heading, user: user, name: 'commune') }

  let(:ad)      { create(:ad, heading: heading, user: user) }

  let(:comment) { create(:comment, ad: ad, user: user) }

  subject        { comment.decorate.as_json }

  its([:id])     { should eq comment.id }

  its([:text])   { should eq comment.text }

  its([:author]) { should eq author }

  its([:ad])     { should eq({ id:  ad.id }) }

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end
end
