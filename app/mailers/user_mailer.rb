class UserMailer < ActionMailer::Base
 default from: "support@pokerradius.com"
  def confirm_account(user)
    @user = user
    @confirmation_code = user.confirmation_code
   #@url  = 'https://pradius.herokuapp.com/users/confirm?confirmation_code='+ "#{@confirmation_code}"
    @url  = 'https://PokerRadius.com/users/confirm?confirmation_code='+ "#{@confirmation_code}"
    mail(from: "support@pokerradius.com" ,to: @user.email,bcc: "PRadius201@gmail.com" ,subject: 'Email Confirmation Required!').deliver

  end

  def confirm_first_account(user)
    @user = user
    @confirmation_code = user.confirmation_code
    @url  = 'https://PokerRadius.com/users/confirm?confirmation_code='+ "#{@confirmation_code}"
    mail(from:"support@pokerradius.com", to: @user.email,bcc: 'PRadius201@gmail.com', subject: 'Email Confirmation Required').deliver

  end

  def forgot_password(user, password)
    @user = user
    @url = 'https://PokerRadius.com/'
    @password = password
    mail(to: @user.email,bcc: "PRadius201@gmail.com" ,subject: 'Your new password').deliver
  end

  def contact_us params
    @name = params[:name]
    @last_name = params[:last_name]
    @category = params[:issue]
    @message = params[:message]
    @email = params[:email]
      mail(from: @email , to: 'Support@PokerRadius.com',bcc: 'PRadius201@gmail.com', subject: 'Contact Us Form Inquiry',from: 'Poker Radius Notifications').deliver
  end

  def invite_friend(user,name, email)
    @user =user

    @name = name
    @email = email
    mail(from:@user.email , to: @email,bcc: "PRadius201@gmail.com" ,subject: 'Join this social poker network',from: 'Poker Radius Notifications').deliver
  end

   def invite_friend_new(email_sender,name, email)
    @email_sender =email_sender
    @name = name
    @email = email
    mail(from: @email_sender , to: @email,bcc: "PRadius201@gmail.com" ,subject: 'Join this social poker network',from: 'Poker Radius Notifications').deliver
  end

  def forum_thread(name,email,message)
    @name = name
    @email = email
    @message = message
    mail(from: @email , to: 'Support@PokerRadius.com',bcc: 'PRadius201@gmail.com', subject: 'New Group Thread Suggestion',from: 'Poker Radius Notifications').deliver

  end

  def welcome(user)
    @user = user
    mail(to: @user.email,bcc: "PRadius201@gmail.com", subject: 'Welcome to the Poker Radius Community!',from: 'Poker Radius Notifications').deliver
  end

  def endorsement(message,user,endorser_user)
    @message = message
    @user =user
    @endorser_user = endorser_user
    @url= "https://PokerRadius.com/users/"+ @user.prid
    mail(to: @user.email,bcc: "PRadius201@gmail.com", subject: "#{@endorser_user.name} Endorsed Your Poker Skills!" ,from: 'Poker Radius Notifications').deliver

  end
  def send_message(receiver,sender,message)
    @message = message
    @receiver =receiver
    @sender= sender
    mail(to: @receiver.email,bcc: "PRadius201@gmail.com", subject: "#{@sender.name} sent you a message..",from: 'Poker Radius Notifications').deliver
  end

  def user_like(post,like_user,post_owner)
  @post = post
  @like_user =like_user
  @post_owner =post_owner
       mail(to: @post_owner.email,bcc: "PRadius201@gmail.com", subject: "#{@like_user.name} liked your comment..",from: 'Poker Radius Notifications').deliver
  end
  def user_comment(post_owner,commenter,post_text)
    @post_owner =  post_owner
    @commenter =commenter
    @post_text =post_text
       mail(to: @post_owner.email,bcc: "PRadius201@gmail.com", subject: "#{@commenter.name}  posted on your comment..",from: 'Poker Radius Notifications').deliver
  end
   def forum_post(sender,receiver,thread_name,message)
     @sender =  sender
     @receiver =receiver
     @message =message
     @thread_name=thread_name
       mail(to: @receiver.email,bcc: "PRadius201@gmail.com", subject: "#{@sender.name}  just posted a comment within the #{@thread_name} message forum",from: 'Poker Radius Notifications').deliver

   end
end
