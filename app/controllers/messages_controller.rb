# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authorize_user, :set_room

  def create
    @message = Message.new(permitted_params)
    @message.user = current_user
    @message.save!

    assign_user_to_room

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @room }
    end
  end

  private

  def permitted_params
    params.require(:message).permit(:content, :room_id)
  end

  def assign_user_to_room
    return if current_user.rooms.include?(@room)

    current_user.rooms << @room
  end

  def set_room
    @room = Room.find(permitted_params[:room_id])
  end
end
