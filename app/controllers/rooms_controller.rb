# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authorize_user

  def new
    @room = Room.new
  end

  def create
    room = Room.new(permitted_params)
    if room.save
      current_user.rooms << room
      redirect_to room_path(room.id), notice: 'Room created!'
    else
      flash.alert = 'Unable to create room'
      redirect_to new_room_path
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    render :new if @room.blank?

    @messages = @room.messages
    @new_message = Message.new
  end

  def index
    @rooms = Room.all
  end

  def destroy; end

  private

  def permitted_params
    params.require(:room).permit(:name, :description)
  end
end
