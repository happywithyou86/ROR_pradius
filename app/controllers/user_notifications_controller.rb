class UserNotificationsController < ApplicationController
  before_action :redirect_non_signed_in_user

  respond_to :json

  def mark_as_read

    if params[:notify_type] == "message"
      @unread_message_notifications.each {|n| n.mark_as_read(current_user)}
    elsif params[:notify_type] == "friend"
      @unread_friend_notifications.each {|n| n.mark_as_read(current_user)}
    else
      # settings notifications ?
    end
    render :json => {}, :status => :ok
  end

  def long_pull_check
    unread_friend_notifications = current_user.unread_notifications_for('new_friend_request').count
    unread_message_notifications = current_user.unread_notifications_for('new_message').count
    render :json => {message_number: unread_message_notifications, request_number: unread_friend_notifications}, :status => :ok
  end


  def update_dropdowns
    if params[:type] == 'messages'
      preloaded_conversations = current_user.mailbox.conversations[0..2]
      render :json => render_to_string( :partial => "/user_messages/messages_dropdown_container", :locals => {:preloaded_conversations => preloaded_conversations} ).to_json, :status => :ok
    elsif params[:type] == 'requests'
      pending_friends = PendingFriend.where('requestee_id = ?', current_user.id).includes(:requestee).includes(:requestee => :user_profile_picture).includes(:requestee => :user_location).to_a
      render :json => render_to_string( :partial => "/pending_friends/friend_requests_container", :locals => {:pending_friends => @pending_friends} ).to_json, :status => :ok
    end


  end

end
