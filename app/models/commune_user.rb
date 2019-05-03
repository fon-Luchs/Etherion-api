class CommuneUser < ApplicationRecord
  belongs_to :commune

  belongs_to :user

  validates :user, presence: true

  validates :commune, presence: true

  validates_with CommuneUser::CommuneUsersQuantityValidator
end
