class ChangeTableProdutos < ActiveRecord::Migration
  def change
    remove_column :produtos, :price
    add_column :produtos, :price, :float
  end
end
