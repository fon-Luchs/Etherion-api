class Room < ApplicationRecord
  belongs_to :commune

  has_many :room_users

  has_many :users, through: :room_users

  validates :commune, presence: true

  validates :name, presence: true

  validates :name, length: { in: 3..15 }

  validates :name, format: { with: /\A([a-zA-Zа-яА-Я])+(([ _][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*+\z/ }
end
