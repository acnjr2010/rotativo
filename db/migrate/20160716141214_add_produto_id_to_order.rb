class AddProdutoIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :produto_id, :integer
    add_index :orders, :produto_id
  end
end
