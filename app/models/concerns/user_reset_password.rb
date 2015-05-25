class UserResetPassword
  def self.reset_password(email)
    user = User.where(email: email).first

    if user
      password = SecureRandom.hex

      # Set new password for user
      user.update_attributes(password: password, password_confirmation: password)

      # Email user here
      UserMailer.forgot_password(user, password)
    end

    return true
  end
end