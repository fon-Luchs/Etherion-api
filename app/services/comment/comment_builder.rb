class Comment::CommentBuilder
  attr_reader :current_user, :params

  def initialize(args = {})
    args ||= {}

    @current_user = args[:current_user]

    @params = args[:params]
  end

  def build
    current_user.comments.new(permitted_params)
  end

  private

  def optional_params
    {
      ad: Ad.find(params[:ad_id]),
      parent_id: params[:parent_id] || 0
    }
  end

  def permitted_params
    params.require(:comment).permit(:text).merge(optional_params)
  end
end
