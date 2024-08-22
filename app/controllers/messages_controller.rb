# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authorize_user

  def create
    message = Message.new(permitted_params)
    message.user_id = current_user.id
    message.save!

    assign_user_to_room

    redirect_to room_path(room_id)
  end

  private

  def permitted_params
    params.require(:message).permit(:content, :room_id)
  end

  def assign_user_to_room
    return if current_user.rooms.map(&:id).include?(room_id)

    current_user.rooms << Room.find(room_id)
  end

  def room_id
    permitted_params[:room_id].to_i
  end
end
