# To deliver this notification:
#
# MessageNotification.with(post: @post).deliver_later(current_user)
# MessageNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  param :message

  def message
    params[:message].content
  end

  def room
    params[:message].room.name
  end

  def user
    params[:message].user.email
  end

  def url
    message_path(params[:message])
  end
end
