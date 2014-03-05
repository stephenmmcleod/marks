class MarksMailer < ActionMailer::Base
  default :from => "stephen.mcleod@sheridancollege.ca"

  def send_message(user, subject)
    require 'mail'
    address = Mail::Address.new user.email
    address.display_name = user.name
    
    @user = user
    mail(to: address, :subject => subject, :reply_to => "Stephen McLeod <stephen.mcleod@sheridancollege.ca>")
  end
end
