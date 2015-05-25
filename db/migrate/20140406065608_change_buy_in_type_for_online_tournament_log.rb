class ChangeBuyInTypeForOnlineTournamentLog < ActiveRecord::Migration
  def change
  	 change_column :online_tournaments, :buy_in, :string
  end
end
