class FriendsController < ApplicationController

  before_action :redirect_non_signed_in_user

  respond_to :json

  def index
    @data = UserProfile.get(current_user.prid, current_user)
    @user = User.find_by_prid(params[:prid])
    @friends = User.friends_of_user(@user).each_slice(20).to_a
  end

  def new
  end

  def delete
    @frienship = Friend.find_all_by_friend_id_and_user_id(params[:friend_id], current_user.id)
    @inverse_frienship = Friend.find_all_by_user_id_and_friend_id(params[:friend_id], current_user.id)
     
     if !@frienship.blank?  
      @frienship.each do |fr|

        fr.delete
      end
     end
     if !@inverse_frienship.blank?
      @inverse_frienship.each do |infr|
        infr.delete
      end
     end
    render json: {}, status: :ok
  end

  def search
    user = User.find(params[:user_id])
    friends = User.friends_of_user(user)
    name_prid_matches = friends.select {|f| f.name.downcase.include?(params[:search].downcase) || f.prid.downcase.include?(params[:search].downcase) }
    if !name_prid_matches.empty?
      render json: render_to_string( partial: 'contacts/contacts_results', locals: { friends: name_prid_matches , profile_view: false} ).to_json, status: :ok
    else
      # begin
      #   initial_location = Geocoder.search(params[:search]).first
      #   lat = initial_location.data['geometry']['location']['lat'].to_f
      #   lng = initial_location.data['geometry']['location']['lng'].to_f
      #   near_friends = UserLocation.near([lat, lng], 35).map(&:user).keep_if {|u| friends.include?(u)}
      #   if near_friends.empty?
      #     render :json => {results: false}, :status => :ok
      #   else
      #     render json: render_to_string( partial: 'contacts/contacts_results', locals: { friends: near_friends, profile_view: false } ).to_json, status: :ok
      #   end
      # rescue
        render :json => {results: false}, :status => :ok
      # end
    end

  end

  def invite
    UserMailer.invite_friend(current_user,params[:first_name], params[:email])
    render json: {}, :status => :ok
  end

end
