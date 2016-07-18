class RenameOrdersColumns < ActiveRecord::Migration
  def change
    rename_column :orders, :produto_id, :setor_id
    rename_column :orders, :price, :valor_bilhete
    add_column :orders, :periodo, :integer
  end
end
