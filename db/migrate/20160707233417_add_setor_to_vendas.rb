class AddSetorToVendas < ActiveRecord::Migration
  def change
    add_column :vendas, :setor, :string
  end
end
