class Heading::HeadingFinder
  attr_reader :current_user, :params

  def initialize(params = {}, current_user = nil)
    @params = params

    @current_user = current_user
  end

  def find
    user.headings.find(params[:id])
  end

  private

  def user
    params[:user_id] ? User.find(params[:user_id]) : current_user
  end
end
