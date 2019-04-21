class Heading::HeadingQuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.user
      record.errors.add :heading, 'Number of headers exceeded' if record.user.headings.count >= 15
    end
  end
end
