# Preview all emails at http://localhost:3000/rails/mailers/user_notifier_mailer
class UserNotifierMailerPreview < ActionMailer::Preview
  def send_pending_reviews
    UserNotifierMailer.with(User.first).send_pending_reviews(User.first)
  end
  def send_signup_email
    UserNotifierMailer.with(User.first).send_signup_email(User.first)
  end
end
