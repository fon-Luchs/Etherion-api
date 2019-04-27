require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:user)     { create(:user) }

  let(:heading)  { create(:heading, user: user, name: 'commune') }

  let(:ad)       { create(:ad, heading: heading, user: user) }

  let(:comment)  { create(:comment, ad: ad, user: user) }

  let(:answer)   { create(:comment, ad: ad, user: user, parent_id: comment.id) }

  subject        { comment.decorate.as_json }

  its([:id])     { should eq comment.id }

  its([:text])   { should eq comment.text }

  its([:author]) { should eq author }

  its([:ad])     { should eq({ id:  ad.id }) }

  its([:answers]) { should eq [answer_response] }

  def author
    {
      id: user.id,
      nickname: user.nickname
    }
  end

  def answer_response
    {
      ad: {
        id: ad.id
      },
      author: {
        id: user.id,
        nickname: user.nickname
      },
      id: answer.id,
      text: answer.text,
      parent_id: answer.parent_id,
      answers: []
    }
  end
end
