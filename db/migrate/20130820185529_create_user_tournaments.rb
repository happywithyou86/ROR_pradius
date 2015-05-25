class CreateUserTournaments < ActiveRecord::Migration
  def change
    create_table :user_tournaments do |t|
      t.integer :user_id
      t.string :title
      t.float :buy_in
      t.integer :duration
      t.integer :final_rank
      t.string :best_hand
      t.boolean :win_loss
      t.float :prize
      t.string :type
      t.string :location_type
      t.integer :location_id

      t.timestamps
    end
  end
end
