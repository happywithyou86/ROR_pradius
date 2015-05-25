
class StaticPagesController < ApplicationController
  
  def home
    session[:page_id] = nil
    if current_user
      @posts = Post.post_feed_for_user(current_user, params[:page])
      @data = UserProfile.get(current_user.prid, current_user)
      @memberCount = User.count
      @connectionsCount = Friend.count
    else
      user = User.new
      user.build_favorite_casino
      user.build_favorite_online_site
      user.build_user_location
      @data= { user: user, casinos: Casino.all_as_array, online_sites: OnlineSite.all_as_array }
      @bg = "white"
      render layout: "landing"
    end

  end

  def is_subscibed
    if current_user.user_subscription.blank? && current_user.plan_type != "free_access"
      render json: { subs: true }
    else
      render json: { subs: false }
    end
  end

  def about_us
    @title = "About Poker Radius - Online Social Networking Poker Community"
    render layout: "landing" if !current_user
  end

  def contact
    @title = "Poker Radius - Free Social Network for Poker Players"

    if current_user
      @data = UserProfile.get(current_user.prid, current_user)
    end
    render layout: "landing" if !current_user
  end

  def send_contact_email

    if simple_captcha_valid?
        session[:issue] =nil
        session[:message] =nil
     #TODO: send email to help@pokerradius.com
      if !current_user || (current_user && current_user.opt_in == true)
        UserMailer.contact_us(params)
      end 

      

      flash[:success]="Thank you for contacting us!"
      render json: {sent: true}, status: :ok
    else
      session[:issue] =params[:issue]
      session[:message] = params[:message]
      flash[:error]="Captcha is invalid"
      render json: { sent: false }, :status => :ok 
  

    end
  end

  def privacy_policy
      @title = "Poker Radius Privacy Policy"
      render layout: "landing" if !current_user
  end

  def disclaimer
  end

  def user_agreement
      @title = "Poker Radius User Agreement"      
      render layout: "landing" if !current_user
  end

  def careers
  end
end
