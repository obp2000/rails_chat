class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
    @single_room = Room.find(params[:id])
    @rooms = Room.all
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages
    render 'index'
  end

  def create
    @room = Room.new(room_params)
    @room.save
  end

  private

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name)
  end
end
