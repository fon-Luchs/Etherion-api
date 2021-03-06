class Conversation < ApplicationRecord
  has_many :messages, as: :messageable

  belongs_to :sender, class_name: 'User'

  belongs_to :recipient, class_name: 'User'

  validates :sender_id, presence: true

  validates :recipient_id, presence: true

  validates :sender, uniqueness: { scope: :recipient_id }
end
