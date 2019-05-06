class MessageDecorator < ApplicationDecorator

  delegate_all
  decorates_associations :user

  def as_json(*args)
    {
      author: {
        id: user.id,
        nickname: user.nickname
      },

      id: object.id,
      text: object.text
    }
  end
end
