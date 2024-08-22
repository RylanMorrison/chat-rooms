# frozen_string_literal: true

require 'rails_helper'

describe Message do
  context 'attributes' do
    it 'responds correctly' do
      message = Message.new

      expect(message.respond_to?(:room)).to eq(true)
      expect(message.respond_to?(:user)).to eq(true)
    end
  end
end
