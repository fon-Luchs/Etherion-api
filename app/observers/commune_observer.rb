class CommuneObserver < ActiveRecord::Observer
  def before_create(record)
    Commune::CommunePreBuilder.build(record)
  end

  def after_create(record)
    record.users << record.creator
  end
end
