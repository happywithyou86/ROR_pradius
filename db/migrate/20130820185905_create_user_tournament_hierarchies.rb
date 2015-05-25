class CreateUserTournamentHierarchies < ActiveRecord::Migration
  def change
    create_table :user_tournament_hierarchies do |t|
      t.integer :user_tournament_id
      t.integer :top_paid

      t.timestamps
    end

    add_index :user_tournament_hierarchies, :user_tournament_id
  end
end
