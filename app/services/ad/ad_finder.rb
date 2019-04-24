class Ad::AdFinder
  attr_reader :current_user, :params

  def initialize(args = {})
    args ||= {}
    @current_user = args[:current_user]
    @params = args[:params]
  end

  def find
    current_user.ads.find_by!(id: params[:id], heading_id: params[:heading_id])
  end

  def all
    current_user.ads.where(heading_id: params[:heading_id]).order(created_at: :desc).page(params[:page]).per(32)
  end
end
