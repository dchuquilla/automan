class UserNotifierMailer < ApplicationMailer
  layout "mailer"
  default :from => 'dario.chuquilla@gmail.com'


  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email, :subject => 'Gracias por registrarse en Automan.' )
  end

  def send_pending_reviews(user)
    @user = user
    @owner = user.owner
    @cars = @owner.cars
    mail( :to => @user.email, :subject => "#{@owner.name} tiene mantenimientos pendientes." )
  end
end
