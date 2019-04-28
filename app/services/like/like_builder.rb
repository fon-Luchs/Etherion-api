class Like::LikeBuilder
  attr_reader :current_user, :params

  include ActiveModel::Validations
  include ActiveModel::Callbacks

  define_model_callbacks :build, only: [:after]
  after_build :valid?

  def initialize(args = {})
    args ||= {}
    @current_user = args[:current_user]

    @params = args[:params]
  end

  def build
    current_user.likes.new(permitted_params)
  end

  private

  def likeable
    params[:ad_id] ? Ad.find(params[:ad_id]) : Comment.find(params[:comment_id])
  end

  def permitted_params
    params.require(:like).permit(:kind).merge(likeable: likeable)
  end
end
