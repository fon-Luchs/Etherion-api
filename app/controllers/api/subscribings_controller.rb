class Api::SubscribingsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @subscribe = current_user.subscribings.new(permitted_params)
  end

  def resource
    @subscribe
  end

  def collection
    @subscribings = current_user.subscribings
  end

  def permitted_params
    params.permit.merge(subscriber: User.find(params[:user_id]))
  end
end
