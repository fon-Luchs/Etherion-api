class Like::SelfLikeValidator < ActiveModel::Validator
  def validate(record)
    if record.user
      record.errors.add :like, 'Can\'t take like to myself records' if record.likeable.user == record.user
    end
  end
end
