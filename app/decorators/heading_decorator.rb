class HeadingDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :user

  def as_json(*args)
    {
        author: {
          id: user.id,
          nickname: user.nickname
        },
      id: object.id,
      name: object.name,
      ads: object.ads.decorate.as_json
    }
  end
end
