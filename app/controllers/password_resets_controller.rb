class PasswordResetsController < ApplicationController
  #before_action :redirect_non_signed_in_user

  def new
  end

  def create
    UserResetPassword.reset_password(params[:email])

    flash[:success] = "Password sent!"

    redirect_to password_resets_new_path
  end
end
