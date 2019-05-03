class Api::CommunesController < BaseController
  before_action :build_resource, only: :create

  def update
    admin? ? super : head(403)
  end

  def destroy
    admin? ? super : head(403)
  end

  private

  def build_resource
    @commune = Commune.new(resource_params.merge(creator: current_user))
  end

  def resource
    @commune ||= Commune.find(params[:id])
  end

  def resource_params
    params.require(:commune).permit(:name)
  end

  def admin?
    resource.creator == current_user
  end
end
