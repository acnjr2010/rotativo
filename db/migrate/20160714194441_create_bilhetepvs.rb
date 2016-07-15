class CreateBilhetepvs < ActiveRecord::Migration
  def change
    create_table :bilhetepvs do |t|
      t.integer :forma_pagamento
      t.string :cnpj
      t.string :placa_veiculo
      t.integer :vendido_por
      t.float :valor_bilhete
      t.integer :setor_id

      t.timestamps null: false
    end
  end
end
