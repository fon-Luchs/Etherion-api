class Api::AnswersController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @answer = Comment::CommentBuilder.new(current_user: current_user, params: params).build
  end

  def resource
    @answer
  end
end
