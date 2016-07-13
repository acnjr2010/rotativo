class RemoveVeiculoToBilhete < ActiveRecord::Migration
  def change
    remove_column :bilhetes, :veiculo
    rename_column :bilhetes, :preco, :valor_bilhete
    rename_column :bilhetes, :setor, :setor_id
  end
end
