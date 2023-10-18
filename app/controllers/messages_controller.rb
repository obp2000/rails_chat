class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
