class UserObserver < ActiveRecord::Observer
  def after_create(record)
    record.headings.create(name: 'Основная')
  end

  def after_touch(record)
    @powerest_user = User.find_by(polit_power: User.maximum(:polit_power))

    moderator_changer(record) if record == @powerest_user
  end

  private

  def moderator_changer(record)
    @moderator = User.find_by(moderator: true)

    record.update(moderator: true) unless @moderator || @moderator == record
  end
end
