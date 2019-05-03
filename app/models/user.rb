class User < ApplicationRecord
  has_secure_password

  has_one :auth_token, dependent: :destroy

  has_one :commune, foreign_key: :creator_id, dependent: :destroy

  has_one :commune_user, dependent: :destroy

  has_one :active_commune, through: :commune_user, source: :commune

  has_many :headings, dependent: :destroy

  has_many :ads, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments

  has_many :subscribers, foreign_key: :subscriber_id, class_name: 'Subscriber', dependent: :destroy

  has_many :subscribings, foreign_key: :subscribing_id, class_name: 'Subscriber', dependent: :destroy

  validates :login, length: { in: 3..15 }

  validates :login, presence: true, uniqueness: { case_sensitive: false }

  validates :login, format: { with: /\A@{1}[a-zA-Z0-9_-]+\z/ }

  validates :nickname, length: { in: 3..15 }

  validates :nickname, format: { with: /\A(([',. -_][a-zA-Zа-яА-Я])?([a-zA-Zа-яА-Я]))+(([',. -_][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*+\z/ }

  validates :nickname, presence: true

  validates :password, length: { minimum: 8 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
