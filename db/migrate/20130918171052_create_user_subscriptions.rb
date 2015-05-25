class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|
      t.integer :user_id
      t.string :stripe_customer_token

      t.timestamps
    end

    add_index :user_subscriptions, :user_id
  end
end
