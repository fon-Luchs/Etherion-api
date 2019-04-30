class Api::SubscribersController < BaseController
  private

  def collection
    @subscribers = current_user.subscribers
  end
end
