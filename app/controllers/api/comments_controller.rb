class Api::CommentsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @comment = Comment::CommentBuilder.new(current_user: current_user, params: params).build
  end

  def resource
    @comment ||= current_user.comments.find(params[:id])
  end
end
