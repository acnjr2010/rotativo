class AddAtivadoEmToBilhetes < ActiveRecord::Migration
  def change
    remove_column :bilhetes, :descricao
    add_column :bilhetes, :ativado_em, :datetime
    add_column :bilhetes, :vendido_por, :integer
    add_column :bilhetes, :bilhete, :string
    add_column :bilhetes, :status, :integer
  end
end
