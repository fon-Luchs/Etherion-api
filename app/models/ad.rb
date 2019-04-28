class Ad < ApplicationRecord
  belongs_to :heading

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  validates :user, presence: true

  validates :heading, presence: true

  validates :text, presence: true

  validates :text, length: { maximum: 256 }
end
