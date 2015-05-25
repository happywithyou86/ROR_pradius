class PendingFriendsController < ApplicationController
  before_action :find_request, only: [:accept, :ignore]
  before_action :redirect_non_signed_in_user


  def index
    @data = UserProfile.get(current_user.prid, current_user)
    @requests = PendingFriend.friend_requests_for_user(current_user)
    @requests += DeniedFriend.denied_requests_for_user(current_user)
  
     @requests = @requests.paginate(:page => params[:page], :per_page => 11)
    @unread_friend_notifications.each {|n| n.mark_as_read(current_user)}
  end

  def create
    requestee = User.find(params[:pending_friend][:requestee_id])
    if current_user.opt_in == true
      ContactRequestMailer.send_connect_request(params[:pending_friend][:requester_id], params[:pending_friend][:requestee_id],params[:pending_friend][:how_you_know_him],params[:pending_friend][:message])
    end
    @pending_friend = PendingFriend.create(pending_friend_params)
    respond_to  do |format|
      format.js { render json: {}, status: :ok }
      format.json { render json: {}, status: :created }
    end
  end


  def sort
    requests = PendingFriend.friend_requests_for_user(current_user)
    requests.reverse! if params[:sort] == 'oldest'
    render :json => render_to_string( partial: '/pending_friends/pending_friend_requests', locals: { requests: requests } ).to_json, status: :ok
  end

  def accept
    
    if !@requests.blank?
      @requests.each {|r| r.accept!}
      @friends = User.friends_of_user(current_user).each_slice(20).to_a.flatten!
     render json: { partial:  render_to_string( :partial => '/contacts/contacts_results', :locals => { :friends => @friends,:profile_view=> false }) ,type: "accept"}.to_json, status: :ok

    else
       @denied_requests.each {|r| r.accept!}
       render :json => {}, :status => :ok
    end
  end

  def ignore
    if ! @requests.blank?
      @requests.each {|r| r.ignore!}
     else
       @denied_requests.each {|r| r.ignore!}
    end
    render :json => {}, :status => :ok
  end



  private
    def pending_friend_params
      params.require(:pending_friend).permit(:message, :requester_id, :requestee_id, :how_you_know_him)
    end

    def find_request
      @requests = PendingFriend.find_all_by_id(params[:reqIds])
      if @requests.blank?
        @denied_requests = DeniedFriend.find_all_by_id(params[:reqIds])
      end
    end

end
