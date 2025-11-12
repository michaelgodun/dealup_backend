class UserMailer < ApplicationMailer
  def broadcast_email(user)
    @user = user
    mail(to: @user.email, subject: "Message to all users")
  end
end