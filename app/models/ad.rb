class Ad < ApplicationRecord
  belongs_to :heading

  belongs_to :user

  validates :user, presence: true

  validates :heading, presence: true

  validates :text, presence: true

  validates :text, length: { maximum: 256 }
end
