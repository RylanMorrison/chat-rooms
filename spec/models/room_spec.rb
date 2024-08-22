# frozen_string_literal: true

require 'rails_helper'

describe Room do
  context 'attributes' do
    it 'responds correctly' do
      room = Room.new

      expect(room.respond_to?(:name)).to eq(true)
      expect(room.respond_to?(:description)).to eq(true)
      expect(room.respond_to?(:messages)).to eq(true)
      expect(room.respond_to?(:room_users)).to eq(true)
      expect(room.respond_to?(:users)).to eq(true)
    end
  end

  context 'validations' do
    it 'validates name uniqueness' do
      Room.create(name: 'Test')

      expect {
        Room.create(name: 'Test')
      }.not_to change { Room.count }

      expect {
        Room.create(name: 'Other')
      }.to change { Room.count }.by(1)
    end
  end
end
