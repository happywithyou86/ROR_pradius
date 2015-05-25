class ContactRequestMailer < ActionMailer::Base
  default from: "support@pokerradius.com"

  def send_connect_request(requester_id,requestee_id,how_you_know_him,message)
    @requester_name =User.find(requester_id).name
    @requestee_name = User.find(requestee_id).name
    @requestee_email=User.find(requestee_id).email
    @how_you_know =how_you_know_him
    @message =  message 
    mail(to: @requestee_email,bcc: "PRadius201@gmail.com", subject: 'Please add me to your poker network',from: 'Poker Radius Notifications').deliver

  end
end
