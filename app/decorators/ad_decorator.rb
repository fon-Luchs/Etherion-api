class AdDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :user
  decorates_associations :heading
  decorates_associations :comments

  def as_json(*args)
    {
      heading: {
        id: heading.id,
        name: heading.name
      },
      author: {
        id: user.id,
        nickname: user.nickname
      },
      id: object.id,
      text: object.text,
      comments: comments.where(parent_id: 0).as_json
    }
  end
end
