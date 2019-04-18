class Api::ProfilesController < BaseController
  skip_before_action :authenticate!, only: :create

  before_action :build_resource, only: :create

  private

  def build_resource
    @profile = User.new resource_params
  end

  def resource
    @profile ||= current_user
  end

  def resource_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :login, :nickname
    )
  end
end
