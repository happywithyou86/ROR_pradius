class ChangeStatusTypeFieldInPost < ActiveRecord::Migration
  def change
     change_column :posts, :status, :text
  end
end
