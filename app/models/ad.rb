class Ad < ApplicationRecord
  belongs_to :heading

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user, presence: true

  validates :heading, presence: true

  validates :text, presence: true

  validates :text, length: { maximum: 256 }
end
