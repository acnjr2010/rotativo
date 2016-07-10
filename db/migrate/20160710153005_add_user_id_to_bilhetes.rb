class AddUserIdToBilhetes < ActiveRecord::Migration
  def change
    add_column :bilhetes, :user_id, :integer
    add_index :bilhetes, :user_id
  end
end
