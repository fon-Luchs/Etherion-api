class Subscriber::DisallowSelfReferentialSubscribeValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :subscriber, 'Can\'t self refer' if record.subscriber_id == record.subscribing_id
  end
end
