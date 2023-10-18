class Room < ApplicationRecord
  validates :name, uniqueness: true

  after_create_commit { broadcast_append_to 'rooms' }

  has_many :messages
  has_many :users, through: 'messages'
end
