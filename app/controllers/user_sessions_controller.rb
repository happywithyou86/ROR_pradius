class UserSessionsController < ApplicationController
  before_action :redirect_non_signed_in_user, only: [:destroy]


  def create
    user = User.find_by_email(params[:email].downcase)
  if  user and user.authenticate(params[:password]) and user.confirmed_account == false
      
        flash[:success] = " You need to confirm your account before you can login.  Please check your email."

        redirect_to "/"

    else  
     if user and user.authenticate(params[:password]) and user.suspended_user.nil?
      user.sign_in_count = user.sign_in_count + 1
      if  user.sign_in_count == 1
        UserMailer.welcome(user)
      end
      user.save
      sign_in_user(user)

      flash[:success] = "Welcome,  #{user.name}"


      redirect_to "/"
    else
      user = User.find_by_email(params[:email])
      if !user.nil?
        if user.login_attempt_date == Date.today
        user.login_attempt = user.login_attempt + 1
        else
          user.login_attempt_date = Date.today
          user.login_attempt =  1
        end
          user.save
        if user.login_attempt <= 10
          flash[:error] = "Invalid email/password combination."
         elsif    !user.suspended_user.nil?
           flash[:error] = "Your account is locked out. Please contact our support team for further assistance."
         else
           SuspendedUser.create(:user_id=>user.id)
           flash[:error] = "Your account is locked out. Please contact our support team for further assistance."
         end
      else
        flash[:error] = "Invalid email/password combination."
      end

      redirect_to root_url
     end
   end
  end

  def new
  end

  def destroy
    sign_out_user

    flash[:success] = "You've successfully signed out."

    redirect_to root_url
  end
end
