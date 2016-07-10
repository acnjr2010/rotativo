class AddPlacaVeiculoToBilhetes < ActiveRecord::Migration
  def change
    add_column :bilhetes, :placa_veiculo, :string
  end
end
