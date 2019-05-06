class Api::ConversationsController < BaseController
  before_action :build_resource, only: :create

  helper_method :current_id

  private

  def build_resource
    @conversation = Conversation::ConversationBuilder.new(params: params, current_user: current_user).build
  end

  def resource
    @conversation ||= Conversation::UserConversationGetter.get_conversation(current_user, params[:id])
  end

  def collection
    @conversations = Conversation::UserConversationsGetter.get_conversations(current_user)
  end

  def current_id
    current_user.id
  end
end
