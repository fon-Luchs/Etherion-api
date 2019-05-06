class Api::MessagesController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @message = parent.messages.new(resource_params.merge(user_id: current_user.id))
  end

  def resource
    @message ||= Message::MessageResource.call(current_user, parent)
  end

  def resource_params
    params.require(:message).permit(:text)
  end

  def parent
    Message::MessageParent.call(params)
  end
end
