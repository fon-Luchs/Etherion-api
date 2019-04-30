class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    if context[:profile]
      {
        id: object.id,
        email: object.email,
        nickname: object.nickname,
        login: object.login,
        headings: object.headings.decorate.as_json,
        subscribers: object.subscribers.decorate(context: { subscriber_index: true }).as_json,
        subscribings: object.subscribings.decorate(context: { subscribing_index: true }).as_json,
        commune: '',
        polit_power: object.polit_power,
      }

    elsif context[:user_show]
      {
        id: object.id,
        email: object.email,
        nickname: object.nickname,
        login: object.login,
        headings: object.headings.decorate.as_json,
        subscribers: object.subscribers.decorate(context: { subscriber_index: true }).as_json,
        commune: ''
      }

    elsif context[:user_index]
      {
        id: object.id,
        nickname: object.nickname
      }
    end
  end
end
