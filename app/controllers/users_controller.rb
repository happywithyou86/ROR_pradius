class UsersController < ApplicationController
  before_action :redirect_non_signed_in_user, only: [:show, :edit, :update]

  helper UsersHelper

  helper ActivitiesHelper

  def create
    @user = User.new(user_params)
     result = Geocoder.search(params[:user][:user_location_attributes][:postal_code])
     if result.present? && @user.save 
        @user_location =   @user.user_location
        @user_location.latitude = result.first.latitude
        @user_location.longitude = result.first.longitude
        @user_location.location = result.first.city
        @user_location.state_and_city = result.first.city + " " + result.first.state_code if !result.first.state_code.nil? && !result.first.city.nil?
        country = Country.where('name LIKE ?', "%#{result.first.country}%")
        country.first.country_code =result.first.country_code if !country.blank?
        country.first.save if !country.blank?
        @user_location.country_id = country.first.id if !country.nil?
        @user_location.user_id= @user.id
        @user_location.postal_code = params[:user][:user_location_attributes][:postal_code]
        @user_location.save
        user_favorite_update(@user.id,params[:user][:favorite_online_site_attributes][:online_site_id],params[:user][:favorite_casino_attributes][:casino_id])
        @user.save
        
         @postal_code =true
      else
        @postal_code =false
      end
   
     respond_to do |format|
      # Check if user was created
    #  if @user and @user.save and @user.user_location.save
      if @postal_code == true
        @user_created = true
     else
       #  @user.errors.full_messages.each_with_index do |msg ,index|
       #    if msg == "can't be blank"
       #      msg = ""
       #      #@user.errors.count= @user.errors.count - 1
       #    end
        
       # end
        @user_created = false
      end
       format.js { render layout: false }
    end
  end

  def show
    
      user =  User.custom_url_or_prid(params[:prid])
    if current_user.present? && user.present?
      @data = UserProfile.get(user.prid, current_user)
      UserProfile.visited_site(current_user, @data[:user])
    end
   if @data
     if current_user
        @friends =  User.friends_of_user(@data[:user]).each_slice(20).to_a
        @friends_id =  User.friends_of_user(current_user).each_slice(20).to_a.flatten.collect(&:id)
     end
    else
      flash[:error] = "User does not exist"
      root_url
    end
  end

  def edit
     @data = UserProfile.get(current_user.prid, current_user)
    @user = current_user.format_for_edit
    @data_dropdown = { casinos: Casino.all_as_array, online_sites: OnlineSite.all_as_array }
  end

  def edit_profile
    @user = current_user.format_for_edit
    @data = UserProfile.get(params[:prid], current_user)
  end


  def update

    prid = User.find_by_prid(params[:user][:prid])
   custom_url =  User.find_by_custom_url(params[:user]["custom_url"])
    if (prid && prid != current_user) || (current_user !=custom_url && !custom_url.nil? && !custom_url.custom_url.blank?)
      flash[:error] = "URL already taken.  Please edit profile and try again."
      redirect_to profile_path(current_user.prid)
   
    elsif  params[:edit_profile] == "true"
       if !current_user.user_location.nil?
         current_user.user_location.state_and_city = params[:state_and_city]
          current_user.user_location.save
       end
        if current_user.update_attributes(user_params) && current_user.user_location.save
          if !current_user.custom_url.blank?
            redirect_to profile_path(current_user.custom_url)
          else
            redirect_to profile_path(current_user.prid)
          end
        else
         render 'edit'
        end
     else
         respond_to do |format|
           result = Geocoder.search(params[:user][:user_location_attributes][:postal_code])
            if result.present?
              current_user.user_location.latitude = result.first.latitude
              current_user.user_location.longitude = result.first.longitude
              current_user.user_location.location = result.first.city
              current_user.user_location.state_and_city = result.first.city + " " + result.first.state_code if !result.first.state_code.nil? && !result.first.city.nil?
              country = Country.where('name LIKE ?', "%#{result.first.country}%")
              country.first.country_code =result.first.country_code if !country.blank?
              country.first.save if !country.blank?
              current_user.user_location.country_id = country.first.id if !country.nil?
              current_user.user_location.save
              current_user.opt_in =  params[:user]["opt_in"]
              current_user.save
           elsif result.blank? 
             return false
            end
            # Check if user was created
                if current_user.update_attributes(user_params) and current_user.user_location.save
                  user_favorite_update(current_user.id,params[:user][:favorite_online_site_attributes][:online_site_id],params[:user][:favorite_casino_attributes][:casino_id])
                  @user_updated = true
                  flash[:success] = "Your account is now updated"
                else
                  @user_updated = false
                end
               format.js { render layout: false }
        end
      end
  end

  def confirm

    user = User.where("confirmation_code = ?", params[:confirmation_code]).to_a.first

    if user
      user.update_attributes(confirmed_account: true)

      flash[:success] = "You've successfully confirmed your email.  Please sign in above."


      redirect_to root_url
    else
      flash[:error] = "Sorry, this confirmation code does not work."

      redirect_to root_url
    end
  end

  def request_confirm_code
   @user = User.where("email = ?", params[:email]).to_a.first
    if @user.request_confirm_code.nil? == true
      @user.request_confirm_code = 0
      @user.request_confirm_code = @user.request_confirm_code + 1
     else
     @user.request_confirm_code = @user.request_confirm_code + 1
    end 
     @user.save
      respond_to do |format|
        UserMailer.confirm_first_account(@user) if @user
      format.js { render layout: false }
    end
  end


  private

  def user_params
    if params[:user][:name].present?
      name = params[:user][:name].split(",")

      params[:user][:first_name] = name.first
      params[:user][:last_name] = name.last
    end

    params.require(:user).permit(:name, :password, :password_confirmation, :email, :casino_player, :online_player, :year_started_playing_poker, :prid,:custom_url,
                                 user_location_attributes: [:id,:user_id, :postal_code, :location, :country, :hide_city, :country_id],
                                 favorite_online_site_attributes: [:online_site_id],
                                 favorite_casino_attributes: [:casino_id],
                                 user_profile_picture_attributes: [:url],user_blog_attributes: [:url]
    )
  end


  def user_favorite_update(user_id,online_site_id,casino_id)
    user = User.find(user_id)
    online_site = OnlineSite.find(online_site_id)
     # FavoriteOnlineSite.create(:user_id=>user_id,:online_site_id=>online_site_id)
      if online_site.name.include?"I Don't Play Poker Online"
        user.online_player =false
        user.save
      else
        user.online_player =true
        user.save
      end
      casino_online  = Casino.find(casino_id)
    #  FavoriteCasino.create(:user_id=>user_id,:casino_id=>casino_id)
      if casino_online.name.include?"I Don't Play Poker in Casinos"
        user.casino_player =false
        user.save
      else

        user.casino_player =true
        user.save
      end
  end


end


