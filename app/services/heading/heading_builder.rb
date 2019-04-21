class Heading::HeadingBuilder
  attr_reader :permitted_params, :current_user

  include ActiveModel::Validations
  include ActiveModel::Callbacks

  define_model_callbacks :build, only: [:after]
  after_build :valid?

  def initialize(params = {})
    params ||= {}

    @permitted_params = params[:permitted_params]

    @current_user = params[:current_user]
  end

  def build
    current_user.headings.new(permitted_params)
  end
end
