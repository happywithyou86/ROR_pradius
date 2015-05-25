class AddFieldToTournamentLogAndCashLogTable < ActiveRecord::Migration
  def change
  	add_column :online_tournaments, :tournaments_and_games_date, :date
  	add_column :casino_tournaments, :tournaments_and_games_date, :date
  	add_column :online_cash_games, :tournaments_and_games_date, :date
  	add_column :casino_cash_games, :tournaments_and_games_date, :date
  end
end
