class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_noticed_notifications

  after_create_commit do
    broadcast_append_to room
    notify_users
  end

  private

  def notify_users
    users = room.users.all_except(user).uniq
    MessageNotification.with(message: self).deliver(users)
    users.each do |current_user|
      broadcast_update_to(
        "user_#{current_user.id}",
        target: "user_#{current_user.id}",
        partial: 'notifications/notification',
        locals: { instance: Notification.where(recipient: current_user).last }
      )
    end
  end
end
