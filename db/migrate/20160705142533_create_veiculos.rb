class CreateVeiculos < ActiveRecord::Migration
  def change
    create_table :veiculos do |t|
      t.string :placa_veiculo
      t.string :tipo
      t.string :modelo
      t.string :cor

      t.timestamps null: false
    end
  end
end
