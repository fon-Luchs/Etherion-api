class Like < ApplicationRecord
  belongs_to :user

  belongs_to :likeable, polymorphic: true

  enum kind: [:positive, :negative]

  validates_uniqueness_of :user_id, scope: [:likeable_type, :likeable_id]

  validates_with Like::SelfLikeValidator
end
