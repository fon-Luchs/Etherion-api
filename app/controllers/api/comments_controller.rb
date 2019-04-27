class Api::CommentsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @ad = Ad.find(params[:ad_id])

    @comment = current_user.comments.new(resource_params.merge(ad: @ad))
  end

  def resource
    @comment ||= current_user.comments.find(params[:id])
  end

  def resource_params
    params.require(:comment).permit(:text)
  end
end
