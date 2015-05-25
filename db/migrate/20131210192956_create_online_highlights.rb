class CreateOnlineHighlights < ActiveRecord::Migration
  def change
    create_table :online_highlights do |t|
      t.belongs_to :user

      #############
      # HIGHLIGHT #
      #############

      # Total Profit/Loss
      t.string :total_profit_loss

      # Most Profitable Room
      t.string :most_prof_room

      # Least Profitable Room
      t.string :least_prof_room


      # Most Profitable 24
      t.datetime :most_prof_24_date
      t.string :most_prof_24_amount

      # Largest Loss 24
      t.datetime :largest_loss_24_date
      t.string :largest_loss_24_amount

      # Years Playing
      t.datetime :years_playing_start
      t.datetime :years_playing_end


      ##############
      # TOURNAMENT #
      ##############

      # Total Played
      t.integer :total_tournaments

      # Most Consecutive Hours
      t.integer :tourn_most_consec_hours

      # Total Cashed
      t.integer :tourn_total_cashed

      # Total Not Cashed
      t.integer :tourn_total_not_cashed

      # Best Placement
      t.integer :best_placement
      t.string :best_placement_room
      t.string :best_placement_name
      t.string :best_placement_rank

      # Moest expensive buy in
      t.integer :most_exp_buy_in
      t.string :most_exp_amount
      t.string :most_exp_name
      t.string :most_exp_location


      ########
      # CASH #
      ########

      # Cash Consec Hours
      t.integer :cash_consec_hours

      # Cash Best Hand
      t.integer :cash_best_hand

      # Cash Worst Loss
      t.integer :cash_worst_loss
      t.datetime :cash_worst_loss_date
      t.string :cash_worst_loss_amount
      t.string :cash_worst_loss_room

      # Cash Largest Win
      t.integer :cash_largest_win
      t.datetime :cash_largest_win_date
      t.string :cash_largest_win_amount
      t.string :cash_largest_win_room

      # Cash Total Profit Days
      t.integer :cash_total_profit_days

      # Cash Total Profit Loss
      t.integer :cash_total_loss_days

      t.timestamps
    end
  end
end
