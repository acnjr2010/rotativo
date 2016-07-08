class AddPlacaVeiculoToVendas < ActiveRecord::Migration
  def change
    add_column :vendas, :placa_veiculo, :string
  end
end
