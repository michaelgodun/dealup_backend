class SendEmailToAllUsersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      UserMailer.broadcast_email(user).deliver_later
    end
  end
end
