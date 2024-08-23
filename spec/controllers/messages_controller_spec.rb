# frozen_string_literal: true

require 'rails_helper'

describe MessagesController do
  context 'POST create' do
    let!(:user) { create(:user) }
    let!(:room) { create(:room) }
    subject do
      post :create, params: {
        message: {
          content: 'Test message',
          room_id: room.id
        }
      }
    end

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'creates associated message' do
      subject

      user.reload
      room.reload
      message = Message.last

      expect(user.messages.last).to eq(message)
      expect(user.rooms.last).to eq(room)
      expect(room.messages.last).to eq(message)
      expect(RoomUser.count).to eq(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to("/rooms/#{room.id}")
    end
  end
end
