class User < ApplicationRecord
  has_secure_password

  has_one :auth_token, dependent: :destroy

  validates :login, length: { minimum: 3 }

  validates :login, presence: true, uniqueness: { case_sensitive: false }

  validates :login, format: { with: /\A@{1}[a-zA-Z0-9_-]{3,15}+\z/ }

  validates :nickname, length: { minimum: 3 }

  validates :nickname, format: { with: /\A(([',. -_][a-zA-Zа-яА-Я])?([a-zA-Zа-яА-Я]))+(([',. -_][a-zA-Zа-яА-Я ])?[a-zA-Zа-яА-Я]*)*+\z/ }

  validates :nickname, presence: true

  validates :password, length: { minimum: 8 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
