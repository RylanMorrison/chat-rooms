# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room])
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
