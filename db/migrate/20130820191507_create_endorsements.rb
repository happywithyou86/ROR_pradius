class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.integer :endorser_id
      t.integer :endorsee_id
      t.string :message

      t.timestamps
    end

    add_index(:endorsements, [:endorser_id, :endorsee_id])
  end
end
