class AddUserIdToVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :user_id, :integer
    add_index :veiculos, :user_id
  end
end
