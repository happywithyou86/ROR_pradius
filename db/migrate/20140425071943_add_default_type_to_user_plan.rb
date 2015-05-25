class AddDefaultTypeToUserPlan < ActiveRecord::Migration
  def change
    change_column :users, :plan_type, :string, :default => "basic"
  end
end
