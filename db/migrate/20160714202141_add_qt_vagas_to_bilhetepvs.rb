class AddQtVagasToBilhetepvs < ActiveRecord::Migration
  def change
    add_column :bilhetepvs, :qt_vagas, :integer
  end
end
