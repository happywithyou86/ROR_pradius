class ContactsController < ApplicationController
  before_action :redirect_non_signed_in_user

  def index
    @data = UserProfile.get(current_user.prid, current_user)
    @user = current_user
    @friends = User.friends_of_user(current_user).each_slice(20).to_a
  end
end
