class AddUserIdToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :user_id, :integer
    add_index :bilhetepvs, :user_id
  end
end
