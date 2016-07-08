class AddUserIdToVendas < ActiveRecord::Migration
  def change
    add_column :vendas, :user_id, :integer
    add_index :vendas, :user_id
  end
end
