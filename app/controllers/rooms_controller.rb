# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authorize_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_new

  def new
    @room = Room.new
  end

  def create
    room = Room.new(permitted_params)
    if room.save
      current_user.rooms << room
      redirect_to room, notice: 'Room created!'
    else
      flash.alert = 'Unable to create room'
      redirect_to new_room_path
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
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

  def render_new
    render :new
  end
end
