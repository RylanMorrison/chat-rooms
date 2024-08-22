# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :messages, through: :rooms

  validates :email, uniqueness: true
end
