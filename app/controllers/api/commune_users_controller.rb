class Api::CommuneUsersController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @commune_user = CommuneUser.find_or_initialize_by(resource_params)
  end

  def resource
    @commune_user ||= CommuneUser.find_by!(default_params)
  end

  def resource_params
    params.permit.merge(default_params)
  end

  def default_params
    com = Commune.find(params[:commune_id])
    { commune: com, user: current_user }
  end
end
