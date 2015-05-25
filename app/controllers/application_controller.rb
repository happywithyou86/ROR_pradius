
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 include SimpleCaptcha::ControllerHelpers
 skip_before_filter :verify_authenticity_token  
  before_action :check_for_notifications
  before_filter :requestMethod


  # Deals with handling errors
  #unless Rails.application.config.consider_all_requests_local
  #  rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  #  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  #end

  def requestMethod
    $request = request
  end 

  def check_for_notifications
    return if !current_user
    @pending_friends = PendingFriend.friend_requests_for_user(current_user)[0..2]
    @unread_friend_notifications = current_user.unread_notifications_for('new_friend_request')
    @unread_message_notifications = current_user.unread_notifications_for('new_message')
    @preloaded_conversations = current_user.mailbox.inbox[0..2]
  end

  include UserSessionsHelper

  private

    def render_error(status, exception)
      respond_to do |format|
        format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
        format.all { render nothing: true, status: status }
      end
    end
end

