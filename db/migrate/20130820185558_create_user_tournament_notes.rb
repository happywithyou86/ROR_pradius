class CreateUserTournamentNotes < ActiveRecord::Migration
  def change
    create_table :user_tournament_notes do |t|
      t.integer :user_tournament_id
      t.string :note

      t.timestamps
    end

    add_index :user_tournament_notes, :user_tournament_id
  end
end
