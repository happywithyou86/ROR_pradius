class CreateUserTournamentCapacities < ActiveRecord::Migration
  def change
    create_table :user_tournament_capacities do |t|
      t.integer :user_tournament_id
      t.integer :total

      t.timestamps
    end

    add_index :user_tournament_capacities, :user_tournament_id
  end
end
