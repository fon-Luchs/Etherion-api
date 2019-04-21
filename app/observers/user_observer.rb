class UserObserver < ActiveRecord::Observer
  def after_create(record)
    record.headings.create(name: 'Основная')
  end
end
