class AddPlacaVeiculoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :placa_veiculo, :string
  end
end
