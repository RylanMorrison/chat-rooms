# frozen_string_literal: true

require 'rails_helper'

describe RoomUser do
  context 'attributes' do
    it 'responds correctly' do
      room_user = RoomUser.new

      expect(room_user.respond_to?(:room)).to eq(true)
      expect(room_user.respond_to?(:user)).to eq(true)
    end
  end
end
