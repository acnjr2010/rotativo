class AddAtivadoEmToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :ativado_em, :datetime
  end
end
