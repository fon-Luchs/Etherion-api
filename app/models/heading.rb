class Heading < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  validates :name, presence: true

  validates :name, length: { in: 3..15 }

  validates :name, format: { with: /\A([a-zA-Zа-яА-Я])+(([ _][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*+\z/ }

  validates_with Heading::HeadingQuantityValidator
end
