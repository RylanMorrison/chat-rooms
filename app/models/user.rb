# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages, through: :rooms

  validates_uniqueness_of :email
end
