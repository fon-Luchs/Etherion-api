class Api::AdsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @ad = Ad::AdBuilder.new(params: params, current_user: current_user).build
  end

  def resource
    @ad ||= Ad::AdFinder.new(params: params, current_user: current_user).find
  end

  def collection
    @ads = Ad::AdFinder.new(params: params, current_user: current_user).all
  end

  def resource_params
    params.require(:ad).permit(:text)
  end
end
