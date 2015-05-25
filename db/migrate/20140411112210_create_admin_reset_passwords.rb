class CreateAdminResetPasswords < ActiveRecord::Migration
  def change
    create_table :admin_reset_passwords do |t|
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
