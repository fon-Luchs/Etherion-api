class Comment < ApplicationRecord
  belongs_to :user

  belongs_to :ad

  has_many :likes, as: :likeable, dependent: :destroy

  validates :user, presence: true

  validates :ad, presence: true

  validates :text, presence: true

  validates :text, length: { maximum: 128 }
end
