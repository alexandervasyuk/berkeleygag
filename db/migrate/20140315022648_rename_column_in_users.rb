class RenameColumnInUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :passowrd_digest, :password_digest
  end

  def down
  	#No return
  end
end
