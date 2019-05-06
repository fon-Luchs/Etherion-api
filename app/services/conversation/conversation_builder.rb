class Conversation::ConversationBuilder
  attr_reader :params, :current_user

  def initialize(args = {})
    args ||= args

    @params = args[:params]

    @current_user = args[:current_user]
  end

  def build
    current_user.active_conversations.new(permitted_params)
  end

  private

  def permitted_params
    params.permit.merge(recipient_id: params[:user_id])
  end
end
