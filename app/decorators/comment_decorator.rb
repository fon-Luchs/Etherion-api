class CommentDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :user
  decorates_associations :ad

  def as_json(*args)
    {
      ad: {
        id: ad.id
      },
      author: {
        id: user.id,
        nickname: user.nickname
      },
      id: object.id,
      text: object.text,
      parent_id: object.parent_id,
      answers: answers.as_json
    }
  end

  def answers
    ad.comments.where(parent_id: object.id)
  end
end
