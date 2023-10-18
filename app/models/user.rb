class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create_commit { broadcast_append_to 'users' }

  has_many :messages
  has_many :notifications, as: :recipient, dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user) }

  def self.find_or_create_guest
    email = 'guest@guest.com'
    password = 'password'
    find_by(email:) || create({ email:,
                                password:,
                                password_confirmation: password })
  end
end
