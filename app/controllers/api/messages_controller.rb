class Api::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @message = User.find_or_create_guest.messages.build(message_params)
    if @message.save
      render :show
    else
      render json: { error_messages: ['something wrong'] }, status: 500
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
