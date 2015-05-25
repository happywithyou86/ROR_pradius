class UserMessagesController < ApplicationController
  before_action :redirect_non_signed_in_user

	def index
    @data = UserProfile.get(current_user.prid, current_user)
		@conversations = current_user.mailbox.inbox.paginate(:page => params[:page], :per_page => 11)
    @unread_message_notifications.each {|n| n.mark_as_read(current_user)}
	end

  def sent
    @data = UserProfile.get(current_user.prid, current_user)
    @conversations = current_user.mailbox.sentbox.paginate(:page => params[:page], :per_page => 11)
  end

  def trash
    @data = UserProfile.get(current_user.prid, current_user)
    @conversations = current_user.mailbox.trash.paginate(:page => params[:page], :per_page => 11)
  end


  def new
    @friends = User.friends_of_user(current_user)
    if request.xhr?
      render json: { friends: @friends.map(&:name) }
    end

  end


  def show
    @data = UserProfile.get(current_user.prid, current_user)
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_read(current_user)
  end

  def show_message
    convo = Conversation.find(params[:convoId])
    convo.mark_as_read(current_user)
    render json: render_to_string( :partial => "/user_messages/message_show", :locals => { conversation: convo, type: params[:type] }  ).to_json, satus: :ok
  end



  def send_message
    
    receiver =  params[:to_id].empty? ? User.where("lower(name) = ?", params[:to].downcase).first : User.find(params[:to_id])
    if current_user.opt_in ==true
     UserMailer.send_message(receiver,current_user,params[:body])
    end
    respond_to do |format |

      ## TODO maybe: add a way to prevent users from sending messages to nonfriends
      if receiver && !params[:body].empty? && receiver != current_user
        current_user.send_message(receiver, params[:body], 'Subject')
        receiver.notify('new_message', 'message')


        format.json { render :json => { sent: true }, :status => :ok }
        format.html { redirect_to user_messages_show_path(convo) }
      else
        format.json { render json: { sent: false }, :status => :ok }
        format.html { render :new }
      end

    end

  end


  ####################
  # Mail Box Actions #
  ####################


  # Search Messages
  def search_messages
    conversations = current_user.mailbox.send(params[:type])
    matched = conversations.select do |convo|
      convo.last_message.body.downcase.include?(params[:searchString].downcase) || convo.participants.select {|p| p != current_user}.first.name.downcase.include?(params[:searchString]) #convo.last_message.sender.name.downcase.include?(params[:searchString].downcase)
    end
    render :json => render_to_string( :partial => '/user_messages/message_list_container', :locals => {conversations: matched, type: params[:type]} ).to_json, status: :ok
  end



  def newest_sort
    conversations = current_user.mailbox.send(params[:type])
    conversations.reverse! if params[:sort] == 'oldest'
    render :json => render_to_string( :partial => '/user_messages/message_list_container', :locals => {conversations: conversations, type: params[:type]} ).to_json, status: :ok

  end


  def move_to_trash
    convos = Conversation.find(params[:convoIds])
    convos.each {|c| c.move_to_trash(current_user) }
    render json: {}, status: :ok
  end

  def untrash_convos
    convos = Conversation.find(params[:convoIds])
    convos.each {|c| c.untrash(current_user) }
    render json: {}, status: :ok
  end

  def mark_all_read
    convos = Conversation.find(params[:convoIds])
    convos.each {|c| c.mark_as_read(current_user) }
    render json: {}, status: :ok
  end

  def mark_all_unread
    convos = Conversation.find(params[:convoIds])
    convos.each {|c| c.mark_as_unread(current_user) }
    render json: {}, status: :ok
  end

  def delete_convos
    convos = Conversation.find(params[:convoIds])
    convos.each {|c| c.mark_as_deleted(current_user) }
    render json: {}, status: :ok
  end



  private
    def current_user_conversations
      current_user.mailbox.conversations
    end
end
