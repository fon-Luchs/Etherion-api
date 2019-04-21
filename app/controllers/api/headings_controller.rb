class Api::HeadingsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @heading = Heading::HeadingBuilder.new(
      permitted_params: resource_params,
      current_user: current_user
    ).build
  end

  def resource
    @heading ||= Heading::HeadingFinder.new(params, current_user).find
  end

  def resource_params
    params.require(:heading).permit(:name)
  end
end
