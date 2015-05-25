
RailsAdmin.config do |config|
  ### Popular gems integration
  #include Mailboxer::Models::Messageable


  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)


  config.authorize_with do
    authenticate_or_request_with_http_basic('Administration') do |username, password|
         username == AdminResetPassword.first.name && password == AdminResetPassword.first.password
    end
  end
  # config.model ResetUserPassword do
  #   edit do
  #     field :email
  #     field :password
  #     field :password_confirmation
  #   end
  # end
  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
   config.model 'User' do
    edit do
      field :password
      field :password_confirmation 
    end
      exclude_fields :password_digest #
   end

  config.model 'Advertisement' do
    edit do
      field :position do
       partial 'add_form'
       
      end
      include_all_fields
    end
  end
   config.included_models = ['Advertisement', 'User','Achievement','ActivityComment','ActivityLike','AdminResetPassword','Advertisement','Card','Casino','CasinoCashGame','CasinoHighlight','CasinoTournament','Comment','ContactForm','Country','DeniedFriend','Endorsement','Experience','FavoriteCasino','FavoriteOnlineSite','Forum','ForumPost','ForumThread','Friend','Like','OnlineCashGame','OnlineHighlight','OnlineSite','OnlineTournament','PendingFriend','Post','ProfileVisit','Recommendation','RecommendationComment','SuspendedUser','UserCashGameNote','UserCashGame','UserCashGameType','UserCasinoEventType','UserCasinoEventType','UserFacebook','UserInstagram','UserLocation','UserNickname','UserOnlineEvent','UserOnlineEventType','UserProfilePicture','UserSubscription','UserTournament','UserTournamentCapacity','UserTournamentHierarchy','UserTournamentNote','UserTwitter','UserWallMessage','UserYoutube']
  # config.included_models = ActiveRecord::Base.descendants.map!(&:name)

  config.model 'User' do
      edit do
        field :plan_type do
         partial 'plan_form'
        end
      field :password do
        required false #this line is pseudo code! What is the real thing?
        #ditto this line
      end
       field :password_confirmation do
        required false #this line is pseudo code! What is the real thing?
        #ditto this line
      end
       field :password_digest do
        hide 
         #this line is pseudo code! What is the real thing?
        #ditto this line
      end
        include_all_fields
      end
    end
end

 
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
