class Subscriber < ApplicationRecord
  belongs_to :subscriber, class_name: 'User', foreign_key: :subscriber_id

  belongs_to :subscribing, class_name: 'User', foreign_key: :subscribing_id

  validates :subscriber, presence: true

  validates :subscribing, presence: true

  validates_with Subscriber::DisallowSelfReferentialSubscribeValidator
end
