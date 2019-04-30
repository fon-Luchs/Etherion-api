class SubscriberDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :subscriber

  decorates_associations :subscribing

  def as_json(*args)
    if context[:subscribing_index]
      {
        id: object.id,
        status: 'subscribed',
        user: {
          id: subscriber.id,
          nickname: subscriber.nickname
        }
      }

    elsif context[:subscriber_index]
      {
        id: object.id,
        status: 'subscriber',
        user: {
          id: subscribing.id,
          nickname: subscribing.nickname
        }
      }

    elsif context[:subscribing_create]
      {
        id: object.id,
        status: 'subscribed',
        user: {
          id: subscriber.id,
          nickname: subscriber.nickname,
          login: subscriber.login,
          headings: subscriber.headings.decorate.as_json,
          subscribers: subscriber.subscribers.decorate(context: { subscriber_index: true }).as_json,
          commune: ''
        }
      }
    end
  end
end
