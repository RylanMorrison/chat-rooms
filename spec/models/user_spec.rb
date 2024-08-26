# frozen_string_literal: true

require 'rails_helper'

describe User do
  context 'attributes' do
    it 'responds correctly' do
      user = User.new

      expect(user.respond_to?(:name)).to eq(true)
      expect(user.respond_to?(:email)).to eq(true)
      expect(user.respond_to?(:room_users)).to eq(true)
      expect(user.respond_to?(:rooms)).to eq(true)
      expect(user.respond_to?(:messages)).to eq(true)
    end
  end

  context 'validations' do
    it 'validates email uniqueness' do
      User.create(email: 'test@email.com', password: '12345')

      expect do
        User.create(email: 'test@email.com', password: '12345')
      end.not_to(change(User, :count))

      expect do
        User.create(email: 'other@email.com', password: '12345')
      end.to(change(User, :count).by(1))
    end
  end
end
