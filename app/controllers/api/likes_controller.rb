class Api::LikesController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @like = Like::LikeBuilder.new(params: params, current_user: current_user).build
  end

  def resource
    @like
  end
end
