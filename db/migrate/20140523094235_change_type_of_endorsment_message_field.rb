class ChangeTypeOfEndorsmentMessageField < ActiveRecord::Migration
  def change
    change_column :endorsements, :message, :text
  end
end
