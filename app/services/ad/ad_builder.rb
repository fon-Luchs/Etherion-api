class Ad::AdBuilder
  attr_reader :current_user, :params

  def initialize(args = {})
    args ||= {}
    @current_user = args[:current_user]
    @params = args[:params]
  end

  def build
    current_user.ads.new(permitted_params)
  end

  private

  def permitted_params
    params.require(:ad).permit(:text).merge(heading_id: params[:heading_id])
  end
end
