class Comment < ApplicationRecord
  belongs_to :user

  belongs_to :ad

  validates :user, presence: true

  validates :ad, presence: true

  validates :text, presence: true

  validates :text, length: { maximum: 128 }
end
