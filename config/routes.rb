
Pr::Application.routes.draw do
  resources :advertisements
  root to: "static_pages#home"

  get "contacts/index"

  get "dashboards/index"

  get "feeds/post"

  get "comments/create"
  get "comments/like"
  get "comments/delete"

  post "endorsements/create"

  delete 'endorsements/destroy', to: 'endorsements#destroy'

  get "friends/delete"

  get "searches/results"

  get "recommendations/suggestions"

  get "casinos/index"
  get "casinos/:id", to: "casinos#show", as: 'casino'
  post "casinos/recommend"

  get "online_sites/index"
  get "online_sites/:id", to: "online_sites#show"
  post "online_sites/recommend"

  get "user_plans/new"
  get "user_plans/edit"
  get 'user_plans/no_subscription', to: 'user_plans#no_subscription', as: 'no_subscription'
  get 'user_plans/upgrade'
  get 'user_plans/update'
  get 'user_plans/history'
  get 'user_plans/subscribed'
  post "user_plans/create"

   mount RailsAdmin::Engine => "/O2cq8T1Tj28xW2", :as => 'rails_admin' 
   # do   
  #    get "users/:prid", to: "users#show"

  #  end

  get "home", to: "static_pages#home"
  get "is_subscibed", to: "static_pages#is_subscibed"
  match "/contact", to: "static_pages#contact", as: 'contact_us',via: [:get]
  match "/privacy_policy", to: "static_pages#privacy_policy", as: 'privacy_policy',via: [:get]
  match "/about_us", to: "static_pages#about_us", as: 'about_us',via: [:get]
  get "static_pages/disclaimer"
  match "/user_agreement", to: "static_pages#user_agreement", as: 'user_agreement',via: [:get]
  get "static_pages/careers"
  post 'static_pages/send_email', to: 'static_pages#send_contact_email'

  get "password_resets/new"
  post "password_resets/create"

  get "users/new"

  post "users/create"
  delete 'signout', to: 'user_sessions#destroy'

  get "users/edit"
  get "users/confirm"
  get "users/request_confirm_code"
  patch "users/update"

  # Posts
  get 'posts/index', to: 'posts#index', as: 'posts'
  post 'posts/create', to: 'posts#create'
  post 'posts/like', to: 'posts#like'
  get 'posts/user_lists', to: 'posts#user_lists'
  # Comments
  post 'comments/create', to: 'comments#create'


  # Experiences
  get 'users/experiences/autocomplete', to: 'experiences#autocomplete'
  get 'users/experience/edit', to: 'experiences#edit'
  post "users/experience/create", to: "experiences#create"
  patch 'users/experiences/update', to: 'experiences#update', as: 'experience'
  delete 'users/experiences/destroy', to: 'experiences#destroy'


  # Achievements
  get 'users/achievements/edit', to: 'achievements#edit'
  post "users/achievements/create", to: "achievements#create"
  patch 'users/achievements/update', to: 'achievements#update', as: 'achievement'
  delete 'users/achievements/destroy', to: 'achievements#destroy'


  # Recommendations
  get 'users/recommendations/edit', to: 'recommendations#edit'
  post 'users/recommendations/create', to: 'recommendations#create'
  patch 'users/recommendations/update', to: 'recommendations#update', as: 'recommendation'
  delete 'users/recommendations/destroy', to: 'recommendations#destroy'


  # Endorsements
  post 'users/endorsements/create', to: 'endorsements#create'


  # Mailbox
  get "users/inbox", to: "user_messages#index", as: "user_messages"
  get "users/sent", to: "user_messages#sent", as: "user_messages_sent"
  get "users/trash", to: "user_messages#trash", as: "user_messages_trash"
  get "users/inbox/new", to: "user_messages#new", as: "new_message"
  get "users/inbox/:id", to: "user_messages#show", as: "user_messages_show"

  # Profile
   get "/:prid", to: "users#show", as: "profile"
  get "users/:prid/edit_profile", to: 'users#edit_profile', as: 'edit_profile'

  post "users/messages/send", to: "user_messages#send_message", as: "user_messages_send"
  post "users/messages/reply", to: "user_messages#reply_message", as: "user_messages_reply"

  get "/users/messages/search_messages", to: "user_messages#search_messages"
  get "users/messages/show_message", to: "user_messages#show_message"
  get "users/messages/newest_sort", to: "user_messages#newest_sort"
  put "users/messages/move_to_trash", to: "user_messages#move_to_trash"
  put "users/messages/mark_all_as_read", to: "user_messages#mark_all_read"
  put "users/messages/mark_all_as_unread", to: "user_messages#mark_all_unread"
  put "users/messages/delete_convos", to: "user_messages#delete_convos"
  put "users/messages/untrash_convos", to: "user_messages#untrash_convos"





  get 'users/notifications/long_pull', to: "user_notifications#long_pull_check"
  get 'users/notifications/update_notifications', to: 'user_notifications#update_dropdowns'
  patch "users/notifications/mark_read", to: "user_notifications#mark_as_read"


  # Friend Request

  get "pending_friends/requests", to: 'pending_friends#index', as: 'requests'
  get "pending_friends/requests/sort", to: 'pending_friends#sort'
  post "pending_friends/create", to: 'pending_friends#create'
  post "pending_friends/accept", to: "pending_friends#accept"
  post "pending_friends/ignore", to: "pending_friends#ignore"

  # Friends

  get "users/friends/search", to: "friends#search"
  post 'users/friends/invite', to: 'friends#invite'
  get 'users/:prid/friends', to: 'friends#index', as: 'friends'
  delete 'users/friends/delete', to: 'friends#delete'


  get 'dashboards/online_poker_room', to: 'dashboards#online_poker_room', as: 'dash_online_poker'
  get 'dashboards/online_poker_room/edit', to: 'dashboards#online_poker_room_edit', as: 'dash_online_poker_edit'
  get 'dashboards/casino_poker_room', to: 'dashboards#casino_poker_room', as: 'dash_casino_poker'
  get 'dashboards/casino_poker_room/edit', to: 'dashboards#casino_poker_room_edit', as: 'dash_casino_poker_edit'
  get 'dashboards/life_time', to: 'dashboards#life_time', as: 'dash_life_time'
  get 'dashboards/charts', to: 'dashboards#charts', as: 'dash_charts'
  post "dashboards/online_poker_room/edit", to: 'dashboards#online_edit'
  post "dashboards/casino_poker_room/edit", to: 'dashboards#casino_edit'
  post "dashboards/tournament_log_edit", to: 'dashboards#tournament_log_edit'
  post "dashboards/cash_log_edit", to: 'dashboards#cash_log_edit'
  post "/dashboards/highlight_best_hand", to: 'dashboards#highlight_best_hand'
  get 'dashboards/online_tournament_edit_form', to: 'dashboards#online_tournament_edit_form'
  delete 'dashboards/tournament_log_delete', to: 'dashboards#tournament_log_delete'
  get 'dashboards/online_cash_edit_form', to: 'dashboards#online_cash_edit_form'
  delete 'dashboards/cash_log_delete', to: 'dashboards#cash_log_delete'
  post "webhook/receiver", to: 'webhook#receiver'

  

   
  get "sign_in", to: "user_sessions#new"
  post "user_sessions", to:"user_sessions#create"
  delete "user_sessions", to: "user_sessions#destroy"

  post "activity_likes/create"
  post "activity_comments/create"

  get "errors/error_500"
  get "errors/error_404"

  post "user_locations/update"

  post "user_youtubes/create_or_update"
  post "user_facebooks/create_or_update"
  post "user_twitters/create_or_update"
  post "user_instagrams/create_or_update"

  patch "user_youtubes/create_or_update"
  patch "user_facebooks/create_or_update"
  patch "user_twitters/create_or_update"  
  patch "user_instagrams/create_or_update"

  get "forums/section/:id", to: "forums#section"
  get "forums/thread/:id", to: "forums#thread"
  get "forum/index", to: "forums#index", as: 'forum'
  get "forums/thread/:id/post/new", to: "forums#new_post"
  post "forums/create_post", to: "forums#create_post"
  get "forums/thread/:id/new",to: "forums#new_thread"
  post "forums/create_thread"
  get "forums/search_thread"
  get "forums/search_threads"
  resources :contact_forms

end
