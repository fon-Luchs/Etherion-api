class Commune < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  has_many :commune_users, dependent: :destroy

  has_many :users, through: :commune_users, source: :user

  has_many :rooms

  validates :creator, presence: true

  validates :name, presence: true

  validates :name, length: { in: 3..15 }

  validates :name, format: { with: /\A([a-zA-Zа-яА-Я])+(([ _][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*+\z/ }

  validates_with Commune::CommuneQuantityValidator, on: :create
end
