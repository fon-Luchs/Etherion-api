class LikeObserver < ActiveRecord::Observer
  def after_create(record)
    instances_for(record)
    after_create_increment!
  end

  def after_destroy(record)
    instances_for(record)
    after_destroy_decrement!
  end

  private

  def after_create_increment!
    likeable_increment!
    user_increment!
  end

  def after_destroy_decrement!
    likeable_decrement!
    user_decrement!
  end

  def likeable_increment!
    @likeable.increment!(:rate, @coef)
  end

  def user_increment!
    @user.increment!(:polit_power, @coef)
  end

  def likeable_decrement!
    @likeable.decrement!(:rate, @coef)
  end

  def user_decrement!
    @user.decrement!(:polit_power, @coef)
  end

  def coef(record)
    @coef = record.kind == 'positive' ? 1 : -1
  end

  def instances_for(record)
    @coef = coef record
    @likeable = record.likeable
    @user = record.likeable.user
  end
end
