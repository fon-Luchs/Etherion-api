class Commune::CommuneQuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.creator
      user = record.creator
      record.errors.add :commune, 'Number of communes exceeded' if user.commune
    end
  end
end
