# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150419074933) do

  create_table "achievements", force: true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.string   "online_casino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_comments", force: true do |t|
    t.integer  "user_id"
    t.string   "klass_name"
    t.integer  "klass_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "klass_id"
    t.string   "klass_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_reset_passwords", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", force: true do |t|
    t.string   "url"
    t.integer  "country_id"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "cards", force: true do |t|
    t.string   "value"
    t.string   "number"
    t.string   "suit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards_casino_cash_games", force: true do |t|
    t.integer "card_id"
    t.integer "casino_cash_game_id"
  end

  create_table "cards_casino_highlights", force: true do |t|
    t.integer "card_id"
    t.integer "casino_highlight_id"
  end

  create_table "cards_casino_tournaments", force: true do |t|
    t.integer "card_id"
    t.integer "casino_tournament_id"
  end

  create_table "cards_online_cash_games", force: true do |t|
    t.integer "card_id"
    t.integer "online_cash_game_id"
  end

  create_table "cards_online_highlights", force: true do |t|
    t.integer "card_id"
    t.integer "online_highlight_id"
  end

  create_table "cards_online_tournaments", force: true do |t|
    t.integer "card_id"
    t.integer "online_tournament_id"
  end

  create_table "casino_cash_games", force: true do |t|
    t.integer  "user_id"
    t.string   "win_loss"
    t.string   "location"
    t.string   "stake"
    t.string   "duration"
    t.string   "best_hand"
    t.string   "note"
    t.string   "cash_tourn_type",            default: "Cash"
    t.integer  "hours"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "tournaments_and_games_date"
  end

  create_table "casino_highlights", force: true do |t|
    t.integer  "user_id"
    t.string   "total_profit_loss"
    t.string   "most_prof_room"
    t.string   "least_prof_room"
    t.datetime "most_prof_24_date"
    t.string   "most_prof_24_amount"
    t.datetime "largest_loss_24_date"
    t.string   "largest_loss_24_amount"
    t.datetime "years_playing_start"
    t.datetime "years_playing_end"
    t.integer  "total_tournaments"
    t.integer  "tourn_most_consec_hours"
    t.integer  "tourn_total_cashed"
    t.integer  "tourn_total_not_cashed"
    t.integer  "best_placement"
    t.string   "best_placement_room"
    t.string   "best_placement_name"
    t.string   "best_placement_rank"
    t.integer  "most_exp_buy_in"
    t.string   "most_exp_amount"
    t.string   "most_exp_name"
    t.string   "most_exp_location"
    t.integer  "cash_consec_hours"
    t.integer  "cash_best_hand"
    t.integer  "cash_worst_loss"
    t.datetime "cash_worst_loss_date"
    t.string   "cash_worst_loss_amount"
    t.string   "cash_worst_loss_room"
    t.integer  "cash_largest_win"
    t.datetime "cash_largest_win_date"
    t.string   "cash_largest_win_amount"
    t.string   "cash_largest_win_room"
    t.integer  "cash_total_profit_days"
    t.integer  "cash_total_loss_days"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "most_profitable_24_hours_room"
    t.string   "largest_loss_in_24_hours"
  end

  create_table "casino_tournaments", force: true do |t|
    t.integer  "user_id"
    t.integer  "buy_in"
    t.integer  "players"
    t.string   "win_loss"
    t.string   "location"
    t.string   "title"
    t.string   "rank"
    t.string   "best_hand"
    t.string   "duration"
    t.string   "note"
    t.string   "cash_tourn_type",            default: "Tournament"
    t.integer  "hours"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "tournaments_and_games_date"
  end

  create_table "casinos", force: true do |t|
    t.string   "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "downcased_name"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "photo_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_code"
  end

  create_table "denied_friends", force: true do |t|
    t.integer  "requestee_id"
    t.integer  "requester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "denied_friends", ["requestee_id", "requester_id"], name: "index_denied_friends_on_requestee_id_and_requester_id", using: :btree

  create_table "endorsements", force: true do |t|
    t.integer  "endorser_id"
    t.integer  "endorsee_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "endorsements", ["endorser_id", "endorsee_id"], name: "index_endorsements_on_endorser_id_and_endorsee_id", using: :btree

  create_table "experiences", force: true do |t|
    t.integer  "user_id"
    t.string   "position"
    t.string   "location"
    t.string   "city"
    t.string   "state"
    t.string   "online_casino"
    t.string   "nickname"
    t.text     "description"
    t.boolean  "present"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poker_room_id"
    t.string   "poker_room_type"
  end

  add_index "experiences", ["poker_room_type", "poker_room_id"], name: "index_experiences_on_poker_room_type_and_poker_room_id", using: :btree

  create_table "favorite_casinos", force: true do |t|
    t.integer  "user_id"
    t.integer  "casino_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_casinos", ["user_id"], name: "index_favorite_casinos_on_user_id", using: :btree

  create_table "favorite_online_sites", force: true do |t|
    t.integer  "user_id"
    t.integer  "online_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_online_sites", ["user_id"], name: "index_favorite_online_sites_on_user_id", using: :btree

  create_table "forum_posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "forum_thread_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_sections", force: true do |t|
    t.string   "name"
    t.integer  "forum_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_threads", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "forum_section_id"
    t.integer  "views",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "online_cash_games", force: true do |t|
    t.integer  "user_id"
    t.string   "win_loss"
    t.string   "location"
    t.string   "stake"
    t.string   "duration"
    t.string   "best_hand"
    t.string   "note"
    t.string   "cash_tourn_type",            default: "Cash"
    t.integer  "hours"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "tournaments_and_games_date"
  end

  create_table "online_highlights", force: true do |t|
    t.integer  "user_id"
    t.string   "total_profit_loss"
    t.string   "most_prof_room"
    t.string   "least_prof_room"
    t.datetime "most_prof_24_date"
    t.string   "most_prof_24_amount"
    t.datetime "largest_loss_24_date"
    t.string   "largest_loss_24_amount"
    t.datetime "years_playing_start"
    t.datetime "years_playing_end"
    t.integer  "total_tournaments"
    t.integer  "tourn_most_consec_hours"
    t.integer  "tourn_total_cashed"
    t.integer  "tourn_total_not_cashed"
    t.integer  "best_placement"
    t.string   "best_placement_room"
    t.string   "best_placement_name"
    t.string   "best_placement_rank"
    t.integer  "most_exp_buy_in"
    t.string   "most_exp_amount"
    t.string   "most_exp_name"
    t.string   "most_exp_location"
    t.integer  "cash_consec_hours"
    t.integer  "cash_best_hand"
    t.integer  "cash_worst_loss"
    t.datetime "cash_worst_loss_date"
    t.string   "cash_worst_loss_amount"
    t.string   "cash_worst_loss_room"
    t.integer  "cash_largest_win"
    t.datetime "cash_largest_win_date"
    t.string   "cash_largest_win_amount"
    t.string   "cash_largest_win_room"
    t.integer  "cash_total_profit_days"
    t.integer  "cash_total_loss_days"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "most_profitable_24_hours_room"
    t.string   "largest_loss_in_24_hours"
  end

  create_table "online_sites", force: true do |t|
    t.string   "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "downcased_name"
  end

  create_table "online_tournaments", force: true do |t|
    t.integer  "user_id"
    t.string   "buy_in"
    t.integer  "players"
    t.string   "win_loss"
    t.string   "location"
    t.string   "title"
    t.string   "rank"
    t.string   "best_hand"
    t.string   "note"
    t.string   "duration"
    t.string   "cash_tourn_type",            default: "Tournament"
    t.integer  "hours"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "tournaments_and_games_date"
  end

  create_table "pending_friends", force: true do |t|
    t.integer  "requester_id"
    t.integer  "requestee_id"
    t.string   "how_you_know_him"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pending_friends", ["requestee_id", "requester_id"], name: "index_pending_friends_on_requestee_id_and_requester_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "profile_visits", force: true do |t|
    t.integer  "profile_user_id"
    t.integer  "visitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_visits", ["profile_user_id", "visitor_id"], name: "index_profile_visits_on_profile_user_id_and_visitor_id", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "recommendation_comments", force: true do |t|
    t.integer  "recommendation_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", force: true do |t|
    t.string   "poker_room_type"
    t.integer  "poker_room_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
    t.string   "room_name"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "suspended_users", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suspended_users", ["user_id"], name: "index_suspended_users_on_user_id", using: :btree

  create_table "user_blogs", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_blogs", ["user_id"], name: "index_user_blogs_on_user_id", using: :btree

  create_table "user_cash_game_notes", force: true do |t|
    t.integer  "user_cash_game_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_cash_game_notes", ["user_cash_game_id"], name: "index_user_cash_game_notes_on_user_cash_game_id", using: :btree

  create_table "user_cash_game_types", force: true do |t|
    t.integer  "user_cash_game_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_cash_game_types", ["user_cash_game_id"], name: "index_user_cash_game_types_on_user_cash_game_id", using: :btree

  create_table "user_cash_games", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "stake"
    t.integer  "duration"
    t.string   "best_hand"
    t.boolean  "win_loss"
    t.string   "location_type"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_casino_event_types", force: true do |t|
    t.integer  "user_online_event_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_casino_event_types", ["user_online_event_id"], name: "index_user_casino_event_types_on_user_online_event_id", using: :btree

  create_table "user_casino_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "casino_id"
    t.integer  "hours_played"
    t.integer  "place_taken"
    t.float    "prize"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_facebooks", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_facebooks", ["user_id"], name: "index_user_facebooks_on_user_id", using: :btree

  create_table "user_instagrams", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_instagrams", ["user_id"], name: "index_user_instagrams_on_user_id", using: :btree

  create_table "user_locations", force: true do |t|
    t.integer  "user_id"
    t.string   "location",       default: ""
    t.integer  "country_id",     default: 1
    t.string   "postal_code"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "hide_city",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_and_city"
  end

  add_index "user_locations", ["user_id"], name: "index_user_locations_on_user_id", using: :btree

  create_table "user_nicknames", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "location_type"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_online_event_types", force: true do |t|
    t.integer  "user_online_event_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_online_event_types", ["user_online_event_id"], name: "index_user_online_event_types_on_user_online_event_id", using: :btree

  create_table "user_online_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "hours_played"
    t.integer  "place_taken"
    t.integer  "online_site_id"
    t.float    "prize"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profile_pictures", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profile_pictures", ["user_id"], name: "index_user_profile_pictures_on_user_id", using: :btree

  create_table "user_subscriptions", force: true do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_subscriptions", ["user_id"], name: "index_user_subscriptions_on_user_id", using: :btree

  create_table "user_tournament_capacities", force: true do |t|
    t.integer  "user_tournament_id"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tournament_capacities", ["user_tournament_id"], name: "index_user_tournament_capacities_on_user_tournament_id", using: :btree

  create_table "user_tournament_hierarchies", force: true do |t|
    t.integer  "user_tournament_id"
    t.integer  "top_paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tournament_hierarchies", ["user_tournament_id"], name: "index_user_tournament_hierarchies_on_user_tournament_id", using: :btree

  create_table "user_tournament_notes", force: true do |t|
    t.integer  "user_tournament_id"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tournament_notes", ["user_tournament_id"], name: "index_user_tournament_notes_on_user_tournament_id", using: :btree

  create_table "user_tournaments", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.float    "buy_in"
    t.integer  "duration"
    t.integer  "final_rank"
    t.string   "best_hand"
    t.boolean  "win_loss"
    t.float    "prize"
    t.string   "type"
    t.string   "location_type"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_twitters", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_twitters", ["user_id"], name: "index_user_twitters_on_user_id", using: :btree

  create_table "user_wall_messages", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.integer  "from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_youtubes", force: true do |t|
    t.integer  "user_id"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_youtubes", ["user_id"], name: "index_user_youtubes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "prid"
    t.string   "email"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.string   "name"
    t.boolean  "online_player",                        default: false
    t.boolean  "casino_player",                        default: false
    t.date     "year_started_playing_poker"
    t.string   "confirmation_code"
    t.boolean  "confirmed_account",                    default: false
    t.string   "quote",                                default: "--"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_confirm_code"
    t.boolean  "opt_in",                               default: true
    t.date     "login_attempt_date"
    t.integer  "login_attempt",                        default: 0,       null: false
    t.integer  "sign_in_count",              limit: 8, default: 0
    t.string   "plan_type",                            default: "basic"
    t.string   "custom_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["prid"], name: "index_users_on_prid", using: :btree

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
