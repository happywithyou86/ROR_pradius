class UserPlanMailer < ActionMailer::Base
  default from: "support@pokerradius.com"

  def welcome(user)
    @user = user
    mail(to: @user.email,bcc: 'PRadius201@gmail.com', subject: 'Congratulations!  Premium Plan Membership & Features').deliver
  end

  def decline_payment_mail(user)
   @user = user
    mail(to: @user.email,bcc: 'PRadius201@gmail.com', subject: 'CREDIT CARD DECLINED ON RE-OCCURRING PLAN PAYMENT').deliver
  end
end
