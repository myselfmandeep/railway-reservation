class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  # def welcome_email(user)
  #   @user = user

  #   template = render_to_string(template: 'user_mailer/welcome_email', layout: false)
  #   content = SendGrid::Content.new(type: "text/html", value: template)
    
  #   from, subject, to, template = sender_receiver(), "Welcome mail", sender_receiver(user), content 
  #   mail = SendGrid::Mail.new(from, subject, to, template)
    
  #   sg = SendGrid::API.new(api_key: ENV['SEND_GRID'])
  #   response = sg.client.mail._('send').post(request_body: mail.to_json)

  #   response.body
  # end

  # private

  # def sender_receiver(email=nil)
  #   SendGrid::Email.new(email: email || self.class.default[:from])
  # end
  
end
