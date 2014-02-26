class MarksMailer < ActionMailer::Base
  default :from => "stephen.mcleod@sheridancollege.ca"

  def send_message(message)
    require 'mail'
    address = Mail::Address.new message[:email]
    address.display_name = message[:name]
    @message = message
    mail(to: address, :subject => @message[:subject], :reply_to => "Stephen McLeod <stephen.mcleod@sheridancollege.ca>")
  end
end
